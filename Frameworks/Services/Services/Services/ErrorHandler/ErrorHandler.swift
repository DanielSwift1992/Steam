import UIKit

public final class ErrorHandler {

    // MARK: - Constants

    private enum Constants {
        static let error = "Somthing went wrong!"
        static let cancel = "Cancel"
    }

}

// MARK: - Methods

public extension ErrorHandler {

    static func handle(_ error: Error, controller: UIViewController) {
        let alert = UIAlertController(title: Constants.error,
                                      message: nil,
                                      preferredStyle: .alert)

        alert.addAction(.init(title: Constants.cancel, style: .cancel, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }

}
