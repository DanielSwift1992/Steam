final public class RecentlyPlayedGamesService: BaseRequestService { }

// MARK: - Methods

public extension RecentlyPlayedGamesService {

    func getGames(steamId: String, completion: @escaping BaseCompletion<[Game]>) {
        getGamesList(steamId: steamId) {
            guard let entry = $0.unwrap(with: completion) else { return }
            completion(.success(entry.response.games.map(Game.init)))
        }
    }

}

// MARK: - Private Methods

private extension RecentlyPlayedGamesService {

    func getGamesList(steamId: String,
                      completion: @escaping BaseCompletion<ResponseEntry<GamesListEntry>>) {

        let url = UrlBuilder.getRecentlyPlayedGamesURL(steamId: steamId)
        request(url: url, completion: completion)
    }

}
