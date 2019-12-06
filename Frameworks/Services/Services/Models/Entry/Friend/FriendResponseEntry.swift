struct FriendResponseEntry: Codable {

    let friendslist: FriendsListEntry

    enum CodingKeys: String, CodingKey {
        case friendslist
    }

}
