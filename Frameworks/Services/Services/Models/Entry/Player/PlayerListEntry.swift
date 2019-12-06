struct PlayerListEntry: Codable {

    let players: [PlayerEntry]

    enum CodingKeys: String, CodingKey {
        case players
    }

}
