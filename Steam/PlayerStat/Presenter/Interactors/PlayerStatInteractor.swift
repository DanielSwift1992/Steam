final class PlayerStatInteractor {

    // MARK: - Typealias

    private typealias StatisticResult = Result<[PlayerStat], Error>
    private typealias SchemaResult = Result<[String: String], Error>

    // MARK: - Private Properties

    private let playerStatService = PlayerStatForGameService()


}

// MARK: - Methods

extension PlayerStatInteractor {

    func getBadgeListAndGames(steamId: String,
                              appId: Int,
                              completion: @escaping BaseCompletion<[PlayerStat]>) {
        var statisticResult: StatisticResult?
        var schemaResult: SchemaResult?
        let group = DispatchGroup()

        loadStatistic(steamId: steamId, appId: appId, group: group) { statisticResult = $0 }
        loadSchema(appId: appId, group: group) { schemaResult = $0 }

        group.notify(queue: .main) {
            guard let playerStat = statisticResult?.unwrap(with: completion),
                let schema = schemaResult?.unwrap(with: completion) else {
                    return
            }
            completion(.success(playerStat.match(with: schema)))
        }
    }

}

// MARK: - Private Methods

private extension PlayerStatInteractor {

    func loadStatistic(steamId: String,
                       appId: Int,
                       group: DispatchGroup,
                       completion: @escaping BaseCompletion<[PlayerStat]>) {
        playerStatService.getStatistic(steamId: steamId,
                                       appId: appId,
                                       completion: group.wrap(completion))
    }

    func loadSchema(appId: Int,
                    group: DispatchGroup,
                    completion: @escaping BaseCompletion<[String: String]>) {
        playerStatService.getGameSchema(appId: appId, completion: group.wrap(completion))
    }

}

// MARK: - Private Methods

private extension Array where Element == PlayerStat {

    func match(with schema: [String: String]) -> [PlayerStat] {
        self.compactMap { PlayerStat(playerStat: $0, name: schema[$0.id]) }
    }

}
