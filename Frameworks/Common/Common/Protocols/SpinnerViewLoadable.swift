import UIKit

public protocol SpinnerViewLoadable {
    var spinnerView: SpinnerView { get }
    var viewsForAnimation: [UIView] { get }
    func startLoading()
    func stopLoading()
    func setInitialStateForSpinnerAnimation()
}

public extension SpinnerViewLoadable {

    func startLoading() {
        spinnerView.apply {
            $0.alpha = 1
            $0.spinnerSize = .MLSpinnerSizeSmall
            $0.spinnerColor = Theme.mainAccent
            $0.startAnimating()
        }
    }

    func stopLoading() {
        UIView.animate(withDuration: 0.1) {
            self.viewsForAnimation.forEach { $0.alpha = 1 }
            self.spinnerView.stopAnimatingInstantly()
        }
    }

    func setInitialStateForSpinnerAnimation() {
        viewsForAnimation.forEach { $0.alpha = 0 }
    }

}
