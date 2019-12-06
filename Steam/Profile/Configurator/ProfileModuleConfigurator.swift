import UIKit

final class ProfileModuleConfigurator {

    // MARK: - Methods

    func configure(player: Player) -> ProfileViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(player: player)
        let router = ProfileRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
