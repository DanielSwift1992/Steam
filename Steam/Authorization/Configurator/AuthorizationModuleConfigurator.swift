import UIKit

final class AuthorizationModuleConfigurator {

    // MARK: - Methods

    func configure(handler: @escaping BaseCompletion<SteamID>) -> AuthorizationViewController {
        let view = AuthorizationViewController()
        let presenter = AuthorizationPresenter()
        let router = AuthorizationRouter()

        presenter.handler = handler
        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
