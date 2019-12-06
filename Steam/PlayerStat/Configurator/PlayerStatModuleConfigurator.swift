import UIKit

final class PlayerStatModuleConfigurator {

    // MARK: - Methods

    func configure(steamId: String, game: Game) -> UIViewController {
        let view = PlayerStatStrategyControllerBuilder(appId: game.appId).build()
        let presenter = PlayerStatPresenter(steamId: steamId, game: game)
        let router = PlayerStatRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
