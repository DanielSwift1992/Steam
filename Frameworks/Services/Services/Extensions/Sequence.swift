public extension Sequence {

    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }

    func compactMap<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        compactMap { $0[keyPath: keyPath] }
    }

    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { a, b in
            a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }

    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>,
                               _ predicate: (T, T) -> Bool) -> [Element] {

        return sorted { a, b in
            predicate(a[keyPath: keyPath], b[keyPath: keyPath])
        }
    }

}
