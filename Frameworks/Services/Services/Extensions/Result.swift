public extension Result where Failure: Error {

    func unwrap<T>(with completion: @escaping (Result<T, Error>) -> Void) -> Success? {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            completion(.failure(error))
        }

        return nil
    }

}
