final public class VanityIdService: BaseRequestService { }

// MARK: - Methods

public extension VanityIdService {

    func getSteamId(vanityURL: String, completion: @escaping BaseCompletion<String>) {
        getVanity(vanityURL: vanityURL) {
            guard let entry = $0.unwrap(with: completion) else { return }
            completion(.success(entry.response.steamId))
        }
    }
    
}

// MARK: - Private Methods

private extension VanityIdService {

    func getVanity(vanityURL: String,
                   completion: @escaping BaseCompletion<ResponseEntry<VanityEntry>>) {

        let url = UrlBuilder.getResolveVanityURL(vanityURL)
        request(url: url, completion: completion)
    }

}
