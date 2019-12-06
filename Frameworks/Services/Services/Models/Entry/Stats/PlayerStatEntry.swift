struct PlayerStatEntry: Codable {

    let name: String
    let value: Double

    enum CodingKeys: String, CodingKey {
        case name, value
    }

}
