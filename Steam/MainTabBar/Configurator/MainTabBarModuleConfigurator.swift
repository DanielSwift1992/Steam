import UIKit

final class MainTabBarModuleConfigurator {

    // MARK: - Constants

    private enum Constants {
        static let imageInset = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
    }

    // MARK: - Methods

    func configure(player: Player) -> MainTabBarViewController {
        let view = MainTabBarViewController()
        view.viewControllers = getControllers(player: player, size: view.tabBar.frame.size)

        return view
    }

}

// MARK: - Private Methods

private extension MainTabBarModuleConfigurator {

    func getControllers(player: Player, size: CGSize) -> [UIViewController] {
        let profile = ProfileModuleConfigurator().configure(player: player)
        let gameSession = GameSessionModuleConfigurator().configure(steamId: player.steamId)

        profile.tabBarItem.apply {
            $0.imageInsets = Constants.imageInset
            $0.image = CommonAsset.TabBar.profile.image.af_imageAspectScaled(toFit: size)
        }

        gameSession.tabBarItem.apply {
            $0.imageInsets = Constants.imageInset
            $0.image = CommonAsset.TabBar.sessions.image.af_imageAspectScaled(toFit: size)
        }

        return [profile, gameSession]
    }

}
