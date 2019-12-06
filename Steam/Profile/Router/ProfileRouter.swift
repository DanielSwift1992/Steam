import UIKit

final class ProfileRouter {

    // MARK: - Properties

    weak var view: UIViewController?

}

// MARK: - ProfileRouterInput

extension ProfileRouter: ProfileRouterInput {

    func openStatistic(steamId: String, games: [Game]) {
        let viewController = LocalPlayerStatModuleConfigurator()
            .configure(steamId: steamId, games: games)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }

    func openFriendsList(steamId: String) {
        let viewController = FriendListModuleConfigurator().configure(steamId: steamId)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }

    func openPlayerStatistic(steamId: String, game: Game) {
        let viewController = PlayerStatModuleConfigurator().configure(steamId: steamId,
                                                                      game: game)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }

}
