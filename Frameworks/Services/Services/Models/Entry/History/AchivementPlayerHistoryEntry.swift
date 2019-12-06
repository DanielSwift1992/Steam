import RealmSwift

final class AchivementPlayerHistoryEntry: Object {

    @objc dynamic var steamId = ""
    @objc dynamic var lastUpdated = Date(timeIntervalSince1970: 0)
    dynamic var totalPlayed = List<PlayedGameTimeEntry>()

    override static func primaryKey() -> String? {
        "steamId"
    }

    // MARK: - Initialization

    init(steamId: String) {
        self.steamId = steamId
    }

    required init() { }

}
