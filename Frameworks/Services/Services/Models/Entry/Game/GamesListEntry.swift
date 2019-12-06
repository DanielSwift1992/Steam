struct GamesListEntry: Codable {

    let games: [GameEntry]

    enum CodingKeys: String, CodingKey {
        case games
    }

}
