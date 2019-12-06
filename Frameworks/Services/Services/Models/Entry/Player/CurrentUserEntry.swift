import RealmSwift

final class CurrentUserEntry: Object {

    @objc dynamic var id = "id"
    @objc dynamic var steamId = ""
    @objc dynamic var name = ""
    dynamic var friends = List<PlayerIdEntity>()

    override static func primaryKey() -> String? {
        "id"
    }

    // MARK: - Initialization

    init(steamId: String, name: String) {
        self.steamId = steamId
        self.name = name
    }

    required init() { }

}
