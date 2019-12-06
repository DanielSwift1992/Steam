import RealmSwift

final class AchivementHistoryEntry: Object {

    @objc dynamic var id = ""

    @objc dynamic var steamId = ""
    @objc dynamic var appId = 0
    @objc dynamic var name = ""
    @objc dynamic var date = Date()


    override static func primaryKey() -> String? {
        "id"
    }

    // MARK: - Initialization

    init(steamId: String, appId: Int, name: String) {
        self.steamId = steamId
        self.appId = appId
        self.name = name
        self.id = steamId + String(appId) + name
    }

    required init() { }

}
