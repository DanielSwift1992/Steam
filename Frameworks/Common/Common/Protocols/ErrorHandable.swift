import UIKit
import Services

public protocol ErrorHandable {
    var view: UIViewController? { get }
}

public extension ErrorHandable {

    func handle(_ error: Error) {
        guard let view = view else { return }
        ErrorHandler.handle(error, controller: view)
    }

}

