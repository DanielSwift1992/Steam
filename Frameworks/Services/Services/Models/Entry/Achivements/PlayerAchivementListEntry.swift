struct PlayerAchivementListEntry: Codable {

    let achievements: [PlayerAchivementEntry]

    enum CodingKeys: String, CodingKey {
        case achievements
    }

}
