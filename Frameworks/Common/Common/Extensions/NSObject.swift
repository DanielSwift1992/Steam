public extension NSObject {

    class var nameOfClass: String {
        if let name = NSStringFromClass(self).components(separatedBy: ".").last {
            return name
        }
        return .init()
    }

}
