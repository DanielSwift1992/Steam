import UIKit

final class AppCoordinator {

    // MARK: - Properties

    static var shared = AppCoordinator()

    // MARK: - Initialization

    private init() { }

    // MARK: - Methods

    func configure() {
        BackgroundWorkManager.shared.start()
        configureNavigationBar()
    }

    func launch(window: UIWindow?) {
        let loginController = configureLoginViewController()
        configure(window: window, rootController: loginController)
        window?.makeKeyAndVisible()
    }

}

// MARK: - Private Methods

private extension AppCoordinator {

    func configureLoginViewController() -> UIViewController {
        LoginModuleConfigurator().configure()
    }

    func configure(window: UIWindow?, rootController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: rootController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func configureNavigationBar() {
        UINavigationBar.appearance().barTintColor = Theme.mainBackground
        UINavigationBar.appearance().tintColor = Theme.subText
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: Theme.subText,
            .font: UIFont.systemFont(ofSize: 17.0)
        ]
    }

}
