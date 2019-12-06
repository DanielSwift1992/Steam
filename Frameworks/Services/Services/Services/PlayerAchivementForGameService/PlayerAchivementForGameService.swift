final public class PlayerAchivementForGameService: BaseRequestService { }

// MARK: - Methods

extension PlayerAchivementForGameService {

    func getAchivements(steamId: String,
                        appId: Int,
                        completion: @escaping BaseCompletion<[PlayerAchivementEntry]>) {

        getPlayerAchivementList(steamId: steamId, appId: appId) {
            guard let entry = $0.unwrap(with: completion) else { return }
            completion(.success(entry.playerstats.achievements))
        }
    }

}

// MARK: - Private Methods

private extension PlayerAchivementForGameService {

    func getPlayerAchivementList(steamId: String,
                                 appId: Int,
                                 completion: @escaping BaseCompletion<PlayerAchivementResponseEntry>) {

        let url = UrlBuilder.getUserStatsForGameURL(steamId, appId: appId)
        request(url: url, completion: completion)
    }
}
