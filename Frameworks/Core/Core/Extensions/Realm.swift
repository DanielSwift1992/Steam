import RealmSwift

public extension Realm {

    func writeOnBackground<T: ThreadConfined>(object: T,
                                              errorHandler: ((Swift.Error) -> Void)? = nil,
                                              block: @escaping (Realm, T) -> Void) {

        let wrappedObject = ObjectSafeWrapper(object)

        writeOnBackgroundBase(errorHandler: errorHandler) { realm in
            guard let object = wrappedObject.resolve(from: realm) else {
                errorHandler?(Realm.Error(.fail))
                return
            }

            do {
                try realm.write {
                    block(realm, object)
                }
            }
            catch {
                errorHandler?(error)
            }
        }
    }

    func writeOnBackground<T: ThreadConfined, U: ThreadConfined>(
        object: T,
        value: U,
        errorHandler: ((Swift.Error) -> Void)? = nil,
        block: @escaping (Realm, T, U) -> Void) {

        let wrappedObject = ObjectSafeWrapper(object)
        let wrappedValue = ObjectSafeWrapper(value)

        writeOnBackgroundBase(errorHandler: errorHandler) { realm in

            guard let object = wrappedObject.resolve(from: realm),
                let value = wrappedValue.resolve(from: realm) else {
                    errorHandler?(Realm.Error(.fail))
                    return
            }
            do {
                try realm.write {
                    block(realm, object, value)
                }
            } catch {
                errorHandler?(error)
            }
        }
    }

    func writeOnBackground<T: ThreadConfined, U: ThreadConfined>(
        object: T,
        items: [U],
        errorHandler: ((Swift.Error) -> Void)? = nil,
        block: @escaping (Realm, T, [U]) -> Void) {

        let wrappedObject = ObjectSafeWrapper(object)
        let wrappedItems = items.map { ObjectSafeWrapper($0) }

        writeOnBackgroundBase(errorHandler: errorHandler) { realm in
            guard let object = wrappedObject.resolve(from: realm) else {
                errorHandler?(Realm.Error(.fail))
                return
            }

            let items = wrappedItems.compactMap { $0.resolve(from: realm) }

            do {
                try realm.write {
                    block(realm, object, items)
                }
            } catch {
                errorHandler?(error)
            }
        }
    }

    func writeOnBackground(errorHandler: ((Swift.Error) -> Void)? = nil,
                           block: @escaping (Realm) -> Void) {

        writeOnBackgroundBase { realm in
            do {
                try realm.write {
                    block(realm)
                }
            }
            catch {
                errorHandler?(error)
            }
        }
    }

}

private extension Realm {

    private func writeOnBackgroundBase(errorHandler: ((Swift.Error) -> Void)? = nil,
                                       block: @escaping (Realm) -> Void) {

        let config = self.configuration

        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: config)
                    block(realm)
                }
                catch {
                    errorHandler?(error)
                }
            }
        }
    }

}
