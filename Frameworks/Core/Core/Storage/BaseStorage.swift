import RealmSwift

/// Designed to be inherited, use as a base class
open class BaseStorage {

    // MARK: - Initialization

    public init() { }

    // MARK: - Methods

    open func save<Model: Object>(_ model: Model,
                                  update: Realm.UpdatePolicy = .modified,
                                  callBack: ((Result<Model, Error>) -> Void)? = nil) {
        do {
            let realm = try Realm()

            realm.writeOnBackground(object: model) {
                $0.add($1, update: update)
            }

            callBack?(.success(model))
        } catch {
            log(error)
            callBack?(.failure(error))
        }
    }

    open func get<Model: Object>(_ objectType: Model.Type) -> [Model]? {
        do {
            let realm = try Realm()
            return realm.objects(objectType).map { $0 }
        } catch {
            log(error)
        }

        return nil
    }

    open func getResults<Model: Object>(_ objectType: Model.Type) -> Results<Model>? {
        do {
            let realm = try Realm()
            return realm.objects(objectType)
        } catch {
            log(error)
        }
        
        return nil
    }

    open func get<Model: Object>(_ objectType: Model.Type,
                                 forPrimaryKey: String) -> Model? {

        do {
            let realm = try Realm()
            return realm.object(ofType: objectType, forPrimaryKey: forPrimaryKey)
        } catch {
            log(error)
        }

        return nil
    }

    open func remove<U: Object, T: Object>(from object: T,
                                           path: ReferenceWritableKeyPath<T, List<U>>,
                                           predicate: @escaping (U) -> Bool) {
        do {
            let realm = try Realm()
            realm.writeOnBackground(object: object) { realm, object in

                for (index, element) in object[keyPath: path].reversed().enumerated() {
                    guard predicate(element) else { continue }
                    object[keyPath: path].remove(at: index)
                }

            }
        } catch {
            log(error)
        }
    }

    open func append<U: Object, T: Object>(object: T,
                                           path: ReferenceWritableKeyPath<T, List<U>>,
                                           items: [U]) {
        appendOnBackground(object: object, path: path, items: items, isRemoveAll: false)
    }

    open func set<U: Object, T: Object>(object: T,
                                        path: ReferenceWritableKeyPath<T, List<U>>,
                                        items: [U]) {
        appendOnBackground(object: object, path: path, items: items, isRemoveAll: true)
    }

    open func set<U: Object, T: Object>(object: T,
                                        path: ReferenceWritableKeyPath<T, U>,
                                        value: U) {

        do {
            let realm = try Realm()
            realm.writeOnBackground(object: object, value: value) {
                $1[keyPath: path] = $2
            }
        } catch {
            log(error)
        }
    }

    open func set<U, T: Object>(object: T,
                                        path: ReferenceWritableKeyPath<T, U>,
                                        value: U) {

        do {
            let realm = try Realm()
            realm.writeOnBackground(object: object) {
                $1[keyPath: path] = value
            }
        } catch {
            log(error)
        }
    }

    open func remove<Model: Object>(_ objectType: Model.Type,
                                    callBack: ((Error?) -> Void)? = nil) {

        do {
            let realm = try Realm()

            realm.writeOnBackground {
                let objectsToDelete = $0.objects(objectType)
                $0.delete(objectsToDelete)
            }

            callBack?(nil)
        } catch(let error) {
            log(error)
            callBack?(error)
        }
    }

}

private extension BaseStorage {

    func log(_ error: Error) {
        #if DEBUG
        print("REALM ERROR 🤬", error.localizedDescription)
        #endif
    }

    func appendOnBackground<U: Object, T: Object>(
        object: T,
        path: ReferenceWritableKeyPath<T, List<U>>,
        items: [U],
        isRemoveAll: Bool) {

        do {
            let realm = try Realm()
            realm.writeOnBackground(object: object, items: items) {
                let realm = $0

                let list = $2.reduce(into: List<U>()) { list, value in
                    let checkedValue = U.primaryKey() != nil
                    ? realm.create(U.self, value: value, update: .modified)
                    : value

                    list.append(checkedValue)
                }

                if isRemoveAll {
                    $1[keyPath: path].removeAll()
                }

                $1[keyPath: path].append(objectsIn: list)
            }
        } catch {
            log(error)
        }
    }

}
