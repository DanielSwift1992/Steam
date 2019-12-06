import UIKit

final class LoginModuleConfigurator {

    // MARK: - Methods

    func configure() -> LoginViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter()
        let router = LoginRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
