import UIKit

public class GradientImageView: UIView {

    // MARK: - Properties

    public var image: UIImage? {
        didSet {
            imageLayer.contents = image?.cgImage
        }
    }

    // MARK: - Subviews

    private let gradientLayer = CAGradientLayer()
    private let imageLayer = CALayer()
    private let animation = CABasicAnimation(keyPath: AnimationKeys.locations)

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
        imageLayer.frame = bounds
    }

}

// MARK: - Methods

public extension GradientImageView {

    func startAnimation() {
        gradientLayer.add(animation, forKey: nil)
    }

    func stopAnimation() {
        gradientLayer.removeAllAnimations()
    }

}

// MARK: - Piravate Methods

private extension GradientImageView {

    func setupInitialState() {
        configureViews()
        appendSubviews()
        configureAnimation()
    }

    func configureViews() {
        gradientLayer.apply {
            $0.frame = bounds
            $0.colors = [Theme.mainAccent.cgColor, Theme.subAccent.cgColor]
            $0.locations = [0, 1]
            $0.startPoint = CGPoint(x: 0, y: 0.5)
            $0.endPoint = CGPoint(x: 1, y: 0.5)
            $0.mask = imageLayer
        }

        imageLayer.contentsGravity = .resizeAspect
    }

    func configureAnimation() {
        animation.apply {
            $0.fromValue = gradientLayer.locations
            $0.toValue = [0.2, 0.6]
            $0.duration = 1
            $0.autoreverses = true
            $0.repeatCount = .infinity
        }
    }

}

// MARK: - Layout

private extension GradientImageView {

    func appendSubviews() {
        add(sublayers: gradientLayer)
    }

}



