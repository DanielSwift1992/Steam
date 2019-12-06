import RealmSwift

final class PlayedGameTimeEntry: Object {

    @objc dynamic var appId = 0
    @objc dynamic var time = 0

    // MARK: - Initialization

    init(appId: Int, time: Int) {
        self.appId = appId
        self.time = time
    }

    required init() {
        super.init()
    }

}
