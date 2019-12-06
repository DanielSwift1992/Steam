import UIKit

final class FriendListModuleConfigurator {

    // MARK: - Methods

    func configure(steamId: String) -> FriendListViewController {
        let view = FriendListViewController()
        let presenter = FriendListPresenter(steamId: steamId)
        let router = FriendListRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter

        return view
    }

}
