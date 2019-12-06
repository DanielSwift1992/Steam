struct PlayerAchivementEntry: Codable {

    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }

}
