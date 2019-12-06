final public class PlayerStatForGameService: BaseRequestService { }

// MARK: - Methods

public extension PlayerStatForGameService {

    func getStatistic(steamId: String,
                      appId: Int,
                      completion: @escaping BaseCompletion<[PlayerStat]>) {

        getPlayerStatList(steamId: steamId, appId: appId) {
            guard let entry = $0.unwrap(with: completion) else { return }
            completion(.success(entry.playerstats.stats.map(PlayerStat.init)))
        }
    }

    func getGameSchema(appId: Int,
                       completion: @escaping BaseCompletion<[String: String]>) {

        getSchemaForGame(appId: appId) {
            guard let entry = $0.unwrap(with: completion) else { return }
            let schema = entry.game.stats?.map { ($0.name, $0.displayName) } ?? []
            completion(.success( Dictionary(uniqueKeysWithValues: schema)))
        }
    }

}

// MARK: - Private Methods

private extension PlayerStatForGameService {

    func getPlayerStatList(steamId: String,
                           appId: Int,
                           completion: @escaping BaseCompletion<PlayerStatsResponseEntry>) {

        let url = UrlBuilder.getUserStatsForGameURL(steamId, appId: appId)
        request(url: url, completion: completion)
    }

    func getSchemaForGame(appId: Int,
                          completion: @escaping BaseCompletion<GameSchemaResponseEntry>) {

        let url = UrlBuilder.getGameSchemaURL(appId)
        request(url: url, completion: completion)
    }

}
