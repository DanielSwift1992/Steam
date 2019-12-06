struct GameSchemaResponseEntry: Codable {

    let game: GameSchemaListEntry

    enum CodingKeys: String, CodingKey {
        case game
    }

}
