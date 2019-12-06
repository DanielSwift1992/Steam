import UIKit

final class FriendListRouter {

    // MARK: - Properties

    weak var view: UIViewController?

}

// MARK: - FriendListRouterInput

extension FriendListRouter: FriendListRouterInput {

    func openProfile(player: Player) {
        let viewController = ProfileModuleConfigurator().configure(player: player)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }

}
