final class FirendListInteractor {

    // MARK: - Private Properties

    private let friendListService = FriendListService()
    private let playerService = PlayerService()

}

// MARK: - Methods

extension FirendListInteractor {

    func getFriendList(steamId: String, completion: @escaping BaseCompletion<[Player]>) {
        friendListService.getFriends(steamId: steamId) { [weak self] in
                self?.handleFreindList(result: $0, completion: completion)
        }
    }

}

// MARK: - Private Methods

private extension FirendListInteractor {

    func handleFreindList(result: Result<[String], Error>,
                                completion: @escaping BaseCompletion<[Player]>) {
        switch result {
        case .success(let ids):
            playerService.getPlayerList(ids: ids, completion: completion)
        case .failure(let error):
            completion(.failure(error))
        }
    }

}
