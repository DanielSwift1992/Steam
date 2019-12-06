import UIKit

public final class BackgroundWorkManager: NSObject {

    // MARK: - Constants

    private enum Constants {
        static let timerInterval: TimeInterval = 10
    }

    // MARK: - Properties

    public static let shared = BackgroundWorkManager()

    // MARK: - Pivate Properties

    private let storage = AchivementsHistoryStorage()
    private let recentrlyPlayedService = RecentlyPlayedGamesService()
    private let friendListService = FriendListService()
    private let achivementForGameService = PlayerAchivementForGameService()
    private let semaphore = DispatchSemaphore(value: 1)

    private var historyItemIDs = [String]()
    private var isRequestInProcess = false
    private var onComplited: ((UIBackgroundFetchResult) -> Void)?

}

// MARK: - Actions

private extension BackgroundWorkManager {

    @objc
    func fetchData() {
        setHistoryItemsIfEmpty()

        guard !isRequestInProcess,
            let steamId = historyItemIDs.first else {
                onComplited?(.noData)
                return
        }

        isRequestInProcess = true

        recentrlyPlayedService.getGames(steamId: steamId) {
            self.handleGameFetching(steamId: steamId, result: $0)
        }
    }

}


// MARK: - Methods

public extension BackgroundWorkManager {

    func start(completion: @escaping (UIBackgroundFetchResult) -> Void) {
        self.onComplited = completion
        fetchData()
    }

    func start() {
        // TODO remove comment
        DispatchQueue.global(qos: .background).async {
            self.setTimer()
        }
    }

}

// MARK: - Private Methods

private extension BackgroundWorkManager {

    func setTimer() {
        let timer = Timer.scheduledTimer(timeInterval: Constants.timerInterval,
                                         target: self,
                                         selector: #selector(fetchData),
                                         userInfo: nil,
                                         repeats: true)
        let runLoop = RunLoop.current
        runLoop.add(timer, forMode: .default)
        runLoop.run()
    }

    func setHistoryItemsIfEmpty() {
        guard historyItemIDs.count <= 1,
            let currentUser = storage.getCurrentUser() else {
                return
        }
        semaphore.wait()

        historyItemIDs = ([currentUser.steamId] + currentUser.friends.map(\.steamId))
                .compactMap { storage.getOrCreatePlayerHistory(steamId: $0) }
                .sorted(by: \.lastUpdated)
                .map(\.steamId)

        semaphore.signal()
        uploadFriendsIfNeeded()
    }

    func uploadFriendsIfNeeded() {
        guard historyItemIDs.count <= 1 else { return }
        friendListService.uploadCurrentUserFriends() { _ in self.fetchData() }
    }

    func handleGameFetching(steamId: String,
                            result: Result<[Game], Error>) {

        guard steamId == historyItemIDs.first,
            let historyEntry = storage.getOrCreatePlayerHistory(steamId: steamId),
            let games = try? result.get() else {
                updateIsFinished(steamId: steamId, result: .noData)
                return
        }

        let gamesToUpdate = games.filter { gameItem in
            let playedTime = historyEntry.totalPlayed.first {
                $0.appId == gameItem.appId
                }?.time

            return playedTime != 0 && playedTime != gameItem.playTime
        }

        update(games: gamesToUpdate, for: steamId)
    }

    func update(games: [Game], for steamId: String) {
        guard !games.isEmpty else {
            updateIsFinished(steamId: steamId, result: .noData)
            return
        }

        let group = DispatchGroup()

        games.forEach { gameItem in
            update(steamId: steamId,
                   appId: gameItem.appId,
                   group: group) { result in

                    guard let achivements = try? result.get() else { return }

                    self.storage.save(steamId: steamId,
                                      appId: gameItem.appId,
                                      achivements: achivements.map(\.name))
            }
        }

        group.notify(queue: .global(qos: .background)) {
            self.update(steamId: steamId, with: games)
        }
    }

    func update(steamId: String, appId: Int, group: DispatchGroup,
                completion: @escaping BaseCompletion<[PlayerAchivementEntry]>) {
        achivementForGameService.getAchivements(steamId: steamId,
                                                appId: appId,
                                                completion: group.wrap(completion))
    }

    func update(steamId: String, with games: [Game]) {
        storage.updateHistoryEntry(steamId: steamId, with: games)
        updateIsFinished(steamId: steamId, result: .newData)
    }

    func updateIsFinished(steamId: String, result: UIBackgroundFetchResult) {
        putDownHistoryItem()
        onComplited?(result)
        onComplited = nil
        isRequestInProcess = false

        guard .newData != result else { return }
        storage.setUpdatedPlayerHistory(steamId: steamId)
    }

    func putDownHistoryItem() {
        semaphore.wait()
        let item = historyItemIDs.removeFirst()
        historyItemIDs.append(item)
        semaphore.signal()
    }

}

