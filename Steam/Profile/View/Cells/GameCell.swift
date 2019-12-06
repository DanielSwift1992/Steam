import PinLayout

final class GameCell: UICollectionViewCell {

    // MARK: - Constants

    enum Constants {
        static let cellHeight: CGFloat = 80
    }

    // MARK: - Properties

    override var isHighlighted: Bool {
        didSet {
            setState(isHighlighted: isHighlighted)
        }
    }

    // MARK: - Subviews

    private let imageView = UIImageView()
    private let imageContainerView = UIView()
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    private let textContainerView = UIView()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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

extension GameCell {

    func configure(model: Game) {
        imageView.setImage(url: model.iconUrl)
        titleLabel.text = model.name
        timeLabel.text = model.playTimeHoursRepresentation
        setNeedsLayout()
    }

}

// MARK: - Private Methods

private extension GameCell {

    func setupInitialState() {
        configureViews()
        appendSubviews()
    }

    func configureViews() {
        imageContainerView.apply {
            $0.backgroundColor = Theme.subBackground1
        }

        imageView.apply {
            $0.layer.cornerRadius = 2
            $0.layer.borderColor = Theme.subText.cgColor
            $0.layer.borderWidth = 0.2
            $0.clipsToBounds = true
            $0.backgroundColor = Theme.subBackground1
            $0.contentMode = .scaleAspectFit
        }

        titleLabel.apply {
            $0.textColor = Theme.subText
            $0.font = .systemFont(ofSize: 18, weight: .light)
            $0.numberOfLines = 2
        }

        timeLabel.apply {
            $0.textColor = Theme.textTitle
            $0.font = .systemFont(ofSize: 16, weight: .light)
        }

        backgroundColor = Theme.subBackground2
    }

    func setupForReuse() {
        imageView.af_cancelImageRequest()
        imageView.image = nil
    }

    func setState(isHighlighted: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = isHighlighted
                ? Theme.mainBackground
                : Theme.subBackground2
        }
    }

}

// MARK: - Layout

private extension GameCell {

    func appendSubviews() {
        add(subviews:
            imageContainerView.add(subviews: imageView),
            textContainerView.add(subviews: timeLabel, titleLabel)
        )
    }

    func layoutViews() {
        imageContainerView.pin
            .topLeft()
            .bottom()
            .width(20%)

        imageView.pin
            .size(16)
            .center()

        textContainerView.pin
            .after(of: imageContainerView)
            .vertically()
            .right()

        titleLabel.pin
            .after(of: imageContainerView)
            .marginLeft(15)
            .right(15)
            .sizeToFit(.width)

        timeLabel.pin
            .topLeft(to: titleLabel.anchor.bottomLeft)
            .marginTop(4)
            .bottom()
            .width(of: titleLabel)
            .sizeToFit(.width)
        
        textContainerView.pin
            .wrapContent(.vertically)
            .vCenter()
    }

}
