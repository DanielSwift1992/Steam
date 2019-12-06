import PinLayout

final class PlayerCell: UICollectionViewCell {

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
    private let nameLabel = UILabel()

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

extension PlayerCell {

    func configure(model: Player) {
        imageView.setImage(url: model.avatarURL)
        nameLabel.text = model.personaName
        setNeedsLayout()
    }

}

// MARK: - Private Methods

private extension PlayerCell {

    func setupInitialState() {
        configureViews()
        appendSubviews()
    }

    func configureViews() {
        imageView.apply {
            $0.layer.cornerRadius = 2
            $0.layer.borderColor = Theme.subText.cgColor
            $0.layer.borderWidth = 0.2
            $0.clipsToBounds = true
            $0.backgroundColor = Theme.subBackground1
            $0.contentMode = .scaleAspectFit
        }

        nameLabel.apply {
            $0.textColor = Theme.subText
            $0.font = .systemFont(ofSize: 18)
            $0.numberOfLines = 2
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

private extension PlayerCell {

    func appendSubviews() {
        add(subviews: imageView, nameLabel)
    }

    func layoutViews() {
        imageView.pin
            .size(52)
            .vCenter()
            .left(16)

        nameLabel.pin
            .after(of: imageView)
            .right()
            .marginHorizontal(16)
            .sizeToFit(.width)
            .vCenter()

        imageView.layer.cornerRadius = imageView.frame.height / 2
    }

}
