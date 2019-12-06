struct PlayerStatListEntry: Codable {

    let stats: [PlayerStatEntry]

    enum CodingKeys: String, CodingKey {
        case stats
    }

}
