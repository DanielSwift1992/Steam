import UIKit

public extension UINavigationController {

    func applyDefaultNavigationBarStyle() {
        navigationBar.apply {
            $0.barStyle = .black
            $0.shadowImage = UIImage()
        }
    }

}
