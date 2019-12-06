final public class PlayerAchivementLocalStatService {

    // MARK: - Private Properties

    enum Constants {
        static let predicateSteamAndAppId = "steamId == %@ && appId == %d"
    }

    // MARK: - Private Properties

    private let storage = Storage()

    // MARK: - Initialization

    public init() { }
    
}

// MARK: - Methods

public extension PlayerAchivementLocalStatService {

    func getAvailableAppIds(steamId: String) -> [Int] {
        storage.get(AchivementPlayerHistoryEntry.self, forPrimaryKey: steamId)?
            .totalPlayed
            .lazy
            .filter {
                $0.time != 0
                    && self.isAchivementExist(steamId: steamId, appId: $0.appId)
        }
        .map { $0.appId } ?? []
    }

    func getAchivements(steamId: String,
                        appId: Int,
                        by component: Calendar.Component) -> [ChartDataModel<Date>] {

        let results = storage.getResults(AchivementHistoryEntry.self)?
            .lazy
            .filter(Constants.predicateSteamAndAppId, steamId, appId)
            .map(Achivement.init) ?? []

        let formatter = AchivementFormatter()
        return formatter.convert(achivements: results, by: component)
    }
}

// MARK: - PrivateMethods

private extension PlayerAchivementLocalStatService {

    func isAchivementExist(steamId: String, appId: Int) -> Bool {
        storage.getResults(AchivementHistoryEntry.self)?
            .lazy
            .filter(Constants.predicateSteamAndAppId, steamId, appId)
            .first != nil
    }

}
