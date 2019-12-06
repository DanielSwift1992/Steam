import UIKit

final class LoginRouter {

    // MARK: - Properties

    weak var view: UIViewController?

}

// MARK: - LoginRouterInput

extension LoginRouter: LoginRouterInput {

    func openMainFlow(player: Player) {
        let mainTabBar = MainTabBarModuleConfigurator().configure(player: player)
        view?.navigationController?.setViewControllers([mainTabBar], animated: true)
    }

    func openAuthorizationSteam(completion: @escaping BaseCompletion<SteamID>) {
        let authController = AuthorizationModuleConfigurator()
            .configure(handler: completion)
        let navigationController = UINavigationController(rootViewController:
            authController)
        view?.present(navigationController, animated: true, completion: nil)
    }

}

