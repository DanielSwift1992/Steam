import UIKit

public class GradientButton: UIButton {

    // MARK: - Piravate Properties

    private lazy var gradientLayer = CAGradientLayer()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInitialState()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

}

// MARK: - Piravate Methods

private extension GradientButton {

    func setupInitialState() {
        configureViews()
        appendSubviews()
    }

    func configureViews() {
        gradientLayer.apply {
            $0.frame = self.bounds
            $0.colors = [Theme.mainAccent.cgColor, Theme.subAccent.cgColor]
            $0.startPoint = CGPoint(x: 0, y: 0.5)
            $0.endPoint = CGPoint(x: 1, y: 0.5)
        }
    }

}

// MARK: - Layout

private extension GradientButton {

    func appendSubviews() {
        add(sublayers: gradientLayer)
    }

}
