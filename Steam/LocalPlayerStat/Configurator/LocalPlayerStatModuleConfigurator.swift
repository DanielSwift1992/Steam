import UIKit

final class LocalPlayerStatModuleConfigurator {

    // MARK: - Methods

    func configure(steamId: String, games: [Game]) -> LocalPlayerStatViewController {
        let view = LocalPlayerStatViewController()
        let presenter = LocalPlayerStatPresenter(steamId: steamId, games: games)
        let router = LocalPlayerStatRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
