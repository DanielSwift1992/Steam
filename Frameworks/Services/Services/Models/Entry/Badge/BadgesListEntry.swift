struct BadgesListEntry: Codable {

    let badges: [BadgeEntry]?
    let playerXp: Int?
    let playerLevel: Int?
    let playerXpNeededToLevelUp: Int?
    let playerXpNeededCurrentLevel: Int?

    enum CodingKeys: String, CodingKey {
        case badges = "badges"
        case playerXp = "player_xp"
        case playerLevel = "player_level"
        case playerXpNeededToLevelUp = "player_xp_needed_to_level_up"
        case playerXpNeededCurrentLevel = "player_xp_needed_current_level"
    }

}
