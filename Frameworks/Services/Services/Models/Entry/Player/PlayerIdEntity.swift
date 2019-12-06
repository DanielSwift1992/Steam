import RealmSwift

final class PlayerIdEntity: Object {

    @objc dynamic var steamId = ""

    override static func primaryKey() -> String? {
        "steamId"
    }

    init(steamId: String) {
        self.steamId = steamId
    }

    required init() {
        super.init()
    }

}
