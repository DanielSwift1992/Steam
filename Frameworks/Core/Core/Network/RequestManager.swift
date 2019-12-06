import Alamofire

final public class RequestManager {

    // MARK: - Private Properties

    private var session: Session {
        Alamofire.Session.default
    }

    private var dataRequestStorage: [DataRequest] = []
    private let semaphore = DispatchSemaphore(value: 1)

    // MARK: - Deinitialization

    deinit {
        cancelAll()
    }

}

// MARK: - Methods

public extension RequestManager {

    func cancelAll() {
        dataRequestStorage.forEach { $0.cancel() }
        dataRequestStorage.removeAll()
    }

    func request<T: Decodable>(url: URLConvertible,
                               method: HTTPMethod = .get,
                               parameters: Parameters? = nil,
                               encoding: ParameterEncoding = URLEncoding.default,
                               headers: HTTPHeaders? = nil,
                               completion: @escaping (Result<T, Error>) -> Void) {

        let dataRequest = session.request(url,
                                          method: method,
                                          parameters: parameters,
                                          encoding: encoding,
                                          headers: headers)

        dataRequestStorage.append(dataRequest)

        let queue = Thread.isMainThread
            ? DispatchQueue.main
            : DispatchQueue.global(qos: .background)

        dataRequest.responseData(queue: queue) { [weak self, id = dataRequest.id] in
            self?.semaphore.wait()
            self?.dataRequestStorage.removeAll { $0.id == id }
            self?.semaphore.signal()
            self?.responseHandler($0, completion: completion)
        }
    }

}

// MARK: - Private Methods

private extension RequestManager {

    private func responseHandler<T: Decodable>(_ response: DataResponse<Data, AFError>,
                                               completion: @escaping (Result<T, Error>) -> Void) {
        if let error = response.error {
            completion(.failure(error))
            return
        }

        guard let data = response.data else {
            completion(.failure(RequestDataError.unknown))
            return
        }

        let decoder = JSONDecoder()
        guard let object = try? decoder.decode(T.self, from: data) else {
            completion(.failure(RequestDataError.decodingError))
            return
        }

        completion(.success(object))
    }

}
