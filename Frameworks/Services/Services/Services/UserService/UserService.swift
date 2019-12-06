public final class PlayerService: BaseRequestService {

    // MARK: - Private Properties

    private let storage = Storage()
    private var currentUser: CurrentUserEntry? {
        storage.get(CurrentUserEntry.self)?.first
    }

}

// MARK: - Methods

public extension PlayerService {

    func requestAndSaveAsCurrentUser(from id: String,
                                     completion: @escaping (Result<Player, Error>) -> Void) {

        requestPlayers(ids: [id]) { [weak self] result in
            switch result {
            case .success(let resultEntry):
                self?.handleCurrentUserResponse(result: resultEntry, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getCurrentUserInfo() -> (steamId: String, name: String)? {
        guard let entry = currentUser else { return nil }
        return (entry.steamId, entry.name)
    }

    func getPlayerList(ids: [String], completion: @escaping (Result<[Player], Error>) -> Void) {
        requestPlayers(ids: ids) { result in
            switch result {
            case .success(let resultEntry):
                completion(.success(resultEntry.response.players.map { .init(entry: $0) }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

private extension PlayerService {

    func requestPlayers(ids: [String], completion: @escaping (Result<ResponseEntry<PlayerListEntry>, Error>) -> Void) {
         guard let url = UrlBuilder.getPlayersURL(ids) else {
             completion(.failure(RequestDataError.url))
             return
         }

         request(url: url, completion: completion)
     }

    func handleCurrentUserResponse(result: (ResponseEntry<PlayerListEntry>),
                                completion: @escaping (Result<Player, Error>) -> Void) {
        guard let playerEntry = result.response.players.first else {
            completion(.failure(RequestDataError.empty))
            return
        }

        let currentUser = CurrentUserEntry(steamId: playerEntry.steamId,
                                           name: playerEntry.realName
                                            ?? playerEntry.personaName
                                            ?? playerEntry.steamId)
        storage.save(currentUser)
        completion(.success(.init(entry: playerEntry)))
    }

}
