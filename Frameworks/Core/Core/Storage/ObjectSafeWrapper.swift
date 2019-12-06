import RealmSwift

public final class ObjectSafeWrapper<T: ThreadConfined> {

    private var value: T?
    private var reference: ThreadSafeReference<T>?

    public init(_ object: T) {
        if object.realm == nil {
            value = object
        } else {
            reference = .init(to: object)
        }
    }

    public func resolve(from realm: Realm) -> T? {
        guard let reference = reference else {
            return value
        }
        return realm.resolve(reference)
    }

    public func resolve() -> T?{
        guard let realm = try? Realm() else {
            return value
        }
        return resolve(from: realm)
    }

}
