public extension DispatchGroup {

    func wrap<T>(_ completion: @escaping (T) -> Void) -> (T) -> Void {
        enter()
        return {
            completion($0)
            self.leave()
        }
    }

}
