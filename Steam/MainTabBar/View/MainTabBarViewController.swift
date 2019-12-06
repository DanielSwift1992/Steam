import UIKit

final class MainTabBarViewController: UITabBarController {

    // MARK: - Subviews

    private let layerGradient = CAGradientLayer()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        appendSubviews()
    }

}


// MARK: - Private Methods

extension MainTabBarViewController {

    func configureViews() {
        layerGradient.apply {
            $0.colors = [Theme.mainAccent.cgColor, Theme.subAccent.cgColor]
            $0.startPoint = .init(x: 0, y: 0.5)
            $0.endPoint = .init(x: 1, y: 0.5)
            $0.frame = view.bounds
        }

        tabBar.tintColor = UIColor.white.withAlphaComponent(0.7)
    }

}

// MARK: - Layout

extension MainTabBarViewController {

    func appendSubviews() {
        tabBar.add(sublayers: layerGradient)
    }

}

