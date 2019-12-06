struct FriendsListEntry: Codable {

    let friends: [FriendEntry]

    enum CodingKeys: String, CodingKey {
        case friends
    }

}
