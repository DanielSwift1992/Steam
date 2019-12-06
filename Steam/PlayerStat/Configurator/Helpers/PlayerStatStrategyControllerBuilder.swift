import UIKit

final class PlayerStatStrategyControllerBuilder {

    // MARK: -  Typealias

    typealias Strategy = PlayerStatViewInput & UIViewController

    // MARK: -  Constants

    private enum Constants {
        static let csGoAppId = 730
    }

    // MARK: - Private Properties

    private let appId: Int
    private let controllerTypes = [Constants.csGoAppId: CSGoViewController.self]
    private let defaultController = PlayerStatViewController.self

    // MARK: - Initialization

    init(appId: Int) {
        self.appId = appId
    }


}

// MARK: - Methods

extension PlayerStatStrategyControllerBuilder {

    func build() -> Strategy {
        let type: Strategy.Type = controllerTypes[appId] ?? defaultController
        return type.init()
    }

}
