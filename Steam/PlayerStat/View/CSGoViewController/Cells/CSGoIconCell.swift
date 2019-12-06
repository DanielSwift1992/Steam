import PinLayout

final class CSGoIconCell: UICollectionViewCell {

    // MARK: - Constants

    enum Constants {
        static let cellHeight: CGFloat = 120
    }

    // MARK: - Subviews

    private let imageView = UIImageView()
    private let textContainerView = UIView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    // MARK: - Private Properties

    private var isRightPosition = false {
        didSet {
            setTextAlignment()
        }
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInitialState()
    }

    // MARK: - UICollectionViewCell

    override func prepareForReuse() {
        super.prepareForReuse()
        setupForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }

}

// MARK: - Methods

extension CSGoIconCell {

    func configure(model: CSGoPlayerStat, isRight: Bool) {
        titleLabel.text = model.statType.text
        valueLabel.text = model.value
        imageView.image = model.statType.icon
        isRightPosition = isRight
        setNeedsLayout()
    }

}

// MARK: - Private Methods

private extension CSGoIconCell {

    func setupInitialState() {
        configureViews()
        appendSubviews()
    }

    func configureViews() {
        titleLabel.apply {
            $0.font = .systemFont(ofSize: 18, weight: .light)
            $0.numberOfLines = 1
            $0.textColor = Theme.subText
        }

        valueLabel.apply {
            $0.font = .systemFont(ofSize: 32, weight: .light)
            $0.numberOfLines = 1
            $0.textColor = Theme.textTitle
        }

        imageView.apply {
            $0.backgroundColor = .clear
            $0.tintColor = Theme.subText
            $0.contentMode = .scaleAspectFit
        }

        backgroundColor = .clear
    }

    func setTextAlignment() {
        [valueLabel, titleLabel].forEach {
            $0.textAlignment = isRightPosition ? .right : .left
        }
    }

    func setupForReuse() {
        imageView.af_cancelImageRequest()
        imageView.image = nil
    }

}

// MARK: - Layout

private extension CSGoIconCell {

    func appendSubviews() {
        add(subviews: imageView, textContainerView.add(subviews: titleLabel, valueLabel))
    }

    func layoutViews() {
        isRightPosition ? layoutForRight() : layoutForLeft()
        layoutCommon()
    }

    func layoutForRight() {
        imageView.pin
            .size(48)
            .right(12)
            .vCenter()

        textContainerView.pin
            .before(of: imageView)
            .vertically()
            .left()
    }

    func layoutForLeft() {
        imageView.pin
            .size(40)
            .left(12)
            .vCenter()

        textContainerView.pin
            .after(of: imageView)
            .vertically()
            .right()
    }

    func layoutCommon() {
        titleLabel.pin
            .horizontally(12)
            .top()
            .sizeToFit(.width)

        valueLabel.pin
            .below(of: titleLabel)
            .horizontally(12)
            .sizeToFit(.width)

        textContainerView.pin
            .wrapContent(.vertically)
            .vCenter()
    }

}
