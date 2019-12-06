struct GameSchemaStatEntry: Codable {

    let name: String
    let displayName: String

    enum CodingKeys: String, CodingKey {
        case name, displayName
    }

}
