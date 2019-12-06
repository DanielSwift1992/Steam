open class BaseRequestService {

    // MARK: - Properties

    public let manager = RequestManager()

    // MARK: - Initialization

    public init() { }

    // MARK: - Methods

    open func request<T: Decodable>(url: URL?,
                                    completion: @escaping (Result<T, Error>) -> Void) {

        guard let url = url else {
            completion(.failure(RequestDataError.url))
            return
        }
        manager.request(url: url, completion: completion)
    }

}
