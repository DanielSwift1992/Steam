import Core

public extension Result {

    var error: Error? {
        guard case .failure(let error) = self else {
            return nil
        }
        return error
    }

}
