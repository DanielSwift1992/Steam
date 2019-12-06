import PinLayout

final class RecentlyPlayedCell: UICollectionViewCell {

    // MARK: - Constants

    private enum Constants {
        static let textOffset: (horizontal: CGFloat, vertical: CGFloat) = (172, 88)
        static let titleFont = UIFont.systemFont(ofSize: 18, weight: .light)
        static let timeFont = UIFont.systemFont(ofSize: 16, weight: .light)
    }

    // MARK: - Subviews

    private let imageView = UIImageView()
    private let separatorView = UIView()
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()

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

extension RecentlyPlayedCell {

    func configure(model: Game) {
        imageView.setImage(url: model.logoUrl)
        titleLabel.text = model.name
        timeLabel.text = model.playTimeFor2Weeks
        setNeedsLayout()
    }

}

// MARK: - Private Methods

private extension RecentlyPlayedCell {

    func setupInitialState() {
        configureViews()
        appendSubviews()
    }

    func configureViews() {
        imageView.apply {
            $0.layer.cornerRadius = 4
            $0.layer.borderColor = Theme.subText.cgColor
            $0.layer.borderWidth = 0.5
            $0.clipsToBounds = true
            $0.backgroundColor = Theme.subBackground1
            $0.contentMode = .scaleAspectFill
        }

        titleLabel.apply {
            $0.textColor = Theme.subText
            $0.font = .systemFont(ofSize: 18, weight: .light)
            $0.numberOfLines = 0
        }

        timeLabel.apply {
            $0.textColor = Theme.textTitle
            $0.font = .systemFont(ofSize: 16, weight: .light)
            $0.numberOfLines = 0
        }

        separatorView.apply {
            $0.backgroundColor = Theme.mainAccent
            $0.layer.cornerRadius = 2
        }
        backgroundColor = Theme.mainBackground
    }

    func setupForReuse() {
        imageView.af_cancelImageRequest()
        imageView.image = nil
    }

}

// MARK: - Private Layout Methods

private extension RecentlyPlayedCell {

    func appendSubviews() {
        add(subviews: imageView, separatorView, timeLabel, titleLabel)
    }

    func layoutViews() {

        imageView.pin
            .width(92)
            .height(34.5)
            .left(24)
            .top(12)

        separatorView.pin
            .after(of: imageView, aligned: .center)
            .marginLeft(24)
            .size(4)

        titleLabel.pin
            .top(8)
            .after(of: separatorView)
            .marginLeft(24)
            .right(8)
            .sizeToFit(.width)

        timeLabel.pin
            .below(of: titleLabel)
            .marginTop(8)
            .after(of: separatorView)
            .marginLeft(24)
            .right(8)
            .sizeToFit(.width)
    }

}

// MARK: - Layout

extension RecentlyPlayedCell {

    static func sizeForCell(model: Game, width: CGFloat) -> CGSize {
        let labelWidth = width - Constants.textOffset.horizontal

        let titleHeight = model.name
            .height(width: labelWidth, font: Constants.titleFont)
        let timeHeight = model.playTimeFor2Weeks
            .height(width: labelWidth, font: Constants.timeFont)

        let height = titleHeight + timeHeight + Constants.textOffset.vertical
        return .init(width: width, height: height)
    }

}
