struct GameEntry: Codable {

    let appId: Int
    let name: String?
    let iconUrl: String?
    let logoUrl: String?
    let playTime: Int?
    let playTimeFor2Weeks: Int?

    enum CodingKeys: String, CodingKey {
        case appId = "appid"
        case name = "name"
        case iconUrl = "img_icon_url"
        case logoUrl = "img_logo_url"
        case playTime = "playtime_forever"
        case playTimeFor2Weeks = "playtime_2weeks"
    }

}
