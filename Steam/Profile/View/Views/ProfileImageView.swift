import PinLayout

final class ProfileImageView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let offsetMultiplier: CGFloat = 3
    }

    // MARK: - Subviews

    let imageView = UIImageView()
    private let lineShapeLayer = CAShapeLayer()
    private let lineBackShapeLayer = CAShapeLayer()

    // MARK: - Private Properties

    private var percent: CGFloat = 0 {
        didSet {
            configureLinePath()
        }
    }

    private let lineWidth: CGFloat = 3
    private let lineShadowOffset: CGFloat = 5
    private let lineBackWidth: CGFloat = 1

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInitialState()
    }

    // MARK: - UIView

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }

}

// MARK: - Methods

extension ProfileImageView {

    func set(percent: CGFloat, animationDuration: TimeInterval) {
        self.percent = percent

        let animation = CABasicAnimation(keyPath: AnimationKeys.strokeEnd).apply {
            $0.toValue = 1
            $0.duration = animationDuration
            $0.fillMode = .forwards
            $0.timingFunction = .init(name: CAMediaTimingFunctionName.easeInEaseOut)
            $0.isRemovedOnCompletion = false
        }

        lineShapeLayer.add(animation, forKey: nil)
    }

}

// MARK: - Private Properties

private extension ProfileImageView {

    var side: CGFloat {
        min(frame.width, frame.height)
    }

    var lineOffset: CGFloat {
        lineWidth / 2 + lineShadowOffset
    }

    var lineRadius: CGFloat {
        side / 2 - lineOffset
    }

}

// MARK: - Private Methods

private extension ProfileImageView {

    func setupInitialState() {
        backgroundColor = .clear
        configureViews()
        appendSubviews()
    }

    func configureViews() {
        lineShapeLayer.apply {
            $0.strokeColor = Theme.mainAccent.cgColor
            $0.fillColor = UIColor.clear.cgColor
            $0.shadowColor = Theme.mainAccent.cgColor
            $0.shadowOpacity = 1
            $0.shadowOffset = .zero
            $0.shadowRadius = lineShadowOffset
            $0.lineCap = .round
            $0.strokeEnd = 0
            $0.lineWidth = lineWidth
        }

        lineBackShapeLayer.apply {
            $0.strokeColor = Theme.subText.withAlphaComponent(0.5).cgColor
            $0.fillColor = UIColor.clear.cgColor
            $0.lineCap = .round
            $0.lineWidth = lineBackWidth
        }

        imageView.apply {
            $0.clipsToBounds = true
            $0.backgroundColor = Theme.subBackground1
        }
    }

    func configureLinePath() {
        lineShapeLayer.path = getPath(endPercent: percent).cgPath
    }

    func configureLineBackPath() {
        lineBackShapeLayer.path = getPath(endPercent: 1).cgPath
    }

    func getPath(endPercent: CGFloat) -> UIBezierPath {
        UIBezierPath(arcCenter: imageView.center,
                     radius: lineRadius,
                     startAngle: -.pi / 2,
                     endAngle: CGFloat.pi * 2 * endPercent - CGFloat.pi / 2,
                     clockwise: true)
    }

}

// MARK: - Layout

private extension ProfileImageView {

    func appendSubviews() {
        add(subviews: imageView)
        add(sublayers: lineBackShapeLayer, lineShapeLayer)
    }

    func layoutViews() {
        imageView.pin
        .center()
            .size(side - 2 * lineOffset * Constants.offsetMultiplier)

        imageView.layer.cornerRadius = imageView.frame.height / 2
        configureLineBackPath()
        configureLinePath()
    }

}
