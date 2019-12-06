import UIKit

final class GameSessionModuleConfigurator {

    // MARK: - Methods

    func configure(steamId: String) -> GameSessionViewController {
        let view = GameSessionViewController()
        let presenter = GameSessionPresenter(steamId: steamId)
        let router = GameSessionRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
