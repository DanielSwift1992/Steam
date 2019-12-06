final public class BadgesService: BaseRequestService { }

// MARK: - Methods

public extension BadgesService {

    func getBadges(steamId: String, completion: @escaping BaseCompletion<BadgeList>) {
        getGamesList(steamId: steamId) { result in
            switch result {
            case .success(let entry):
                completion(.success(.init(entry: entry.response)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

// MARK: - Private Methods

private extension BadgesService {

    func getGamesList(steamId: String,
                      completion: @escaping BaseCompletion<ResponseEntry<BadgesListEntry>>) {

        let url = UrlBuilder.getBadgesURL(steamId)
        request(url: url, completion: completion)
    }

}
