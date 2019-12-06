import RealmSwift

final public class FriendListService: BaseRequestService {

    // MARK: - Private Properties

    private let storage = Storage()
    private var currentUser: CurrentUserEntry? {
        storage.get(CurrentUserEntry.self)?.first
    }

}

// MARK: - Methods

public extension FriendListService {

    func getFriends(steamId: String, completion: @escaping BaseCompletion<[String]>) {
        getFirendsList(steamId: steamId) {
            guard let entry = $0.unwrap(with: completion) else { return }
            completion(.success(entry.friendslist.friends.map(\.userId)))
        }
    }

    func uploadCurrentUserFriends(completion: @escaping BaseCompletion<[String]>) {
        guard let currentUser = currentUser else { return }
        getFriends(steamId: currentUser.steamId) { [weak self] in
            guard let friends = $0.unwrap(with: completion) else { return }
            self?.saveFriendsOfCurrent(friends: friends)
            completion(.success(friends))
        }
    }

}

// MARK: - Private Methods

private extension FriendListService {

    func getFirendsList(steamId: String,
                        completion: @escaping BaseCompletion<FriendResponseEntry>) {

        let url = UrlBuilder.getFriendsURL(steamId)
        request(url: url, completion: completion)
    }

    func saveFriendsOfCurrent(friends: [String]) {
        guard let currentUser = currentUser else { return }

        storage.set(object: currentUser,
                    path: \.friends,
                    items: friends.map(PlayerIdEntity.init))
    }

}
