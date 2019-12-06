struct FriendEntry: Codable {

    let userId: String
    let sinceDate: Int?

    enum CodingKeys: String, CodingKey {
        case userId = "steamid"
        case sinceDate = "friend_since"
    }

}
