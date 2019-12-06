struct GameSchemaListEntry: Codable {

    let stats: [GameSchemaStatEntry]?

    enum CodingKeys: String, CodingKey {
        case stats
    }

}
