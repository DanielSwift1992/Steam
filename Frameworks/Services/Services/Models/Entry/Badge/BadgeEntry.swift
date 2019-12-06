struct BadgeEntry: Codable {

    let badgeId: Int
    let level: Int?
    let completionTime: Int?
    let xp: Int?
    let scarcity: Int?

    enum CodingKeys: String, CodingKey {

        case badgeId = "badgeid"
        case level = "level"
        case completionTime = "completion_time"
        case xp = "xp"
        case scarcity = "scarcity"
    }

}
