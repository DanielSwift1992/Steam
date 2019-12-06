import UIKit

public protocol Dissmisable {
    var view: UIViewController? { get }
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

public extension Dissmisable {

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        view?.dismiss(animated: animated, completion: completion)
    }

    func dismiss() {
        dismiss(animated: true, completion: nil)
    }

}
