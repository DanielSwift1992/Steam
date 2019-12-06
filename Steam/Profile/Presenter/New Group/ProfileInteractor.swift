final class ProfileInteractor {

    // MARK: - Typealias

    private typealias GameResult = Result<[Game], Error>
    private typealias BadgeResult = Result<BadgeList, Error>

    // MARK: - Private Properties

    private let ownedGamesService = OwnedGamesService()
    private let badgeService = BadgesService()


}

// MARK: - Methods

extension ProfileInteractor {

    func getBadgeListAndGames(steamId: String,
                              completion: @escaping BaseCompletion<(BadgeList, [Game])>) {
        var badgeResult: BadgeResult?
        var gameResult: GameResult?
        let group = DispatchGroup()

        loadBadgeList(steamId: steamId, group: group) { badgeResult = $0 }
        loadOwnedGames(steamId: steamId, group: group) { gameResult = $0 }

        group.notify(queue: .main) {
            guard let badgeList = badgeResult?.unwrap(with: completion),
                let games = gameResult?.unwrap(with: completion) else {
                    return
            }
            completion(.success((badgeList, games)))
        }
    }

}

// MARK: - Private Methods

private extension ProfileInteractor {

    func loadOwnedGames(steamId: String,
                        group: DispatchGroup,
                        completion: @escaping BaseCompletion<[Game]>) {
        ownedGamesService.getGames(steamId: steamId, completion: group.wrap(completion))
    }

    func loadBadgeList(steamId: String,
                       group: DispatchGroup,
                       completion: @escaping BaseCompletion<BadgeList>) {
        badgeService.getBadges(steamId: steamId, completion: group.wrap(completion))
    }

}
