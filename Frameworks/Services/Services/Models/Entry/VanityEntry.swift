struct VanityEntry: Codable {

    let steamId: String

    enum CodingKeys: String, CodingKey {
        case steamId = "steamid"
    }

}
