import PinLayout

final class PlayerStatCell: UICollectionViewCell {

    // MARK: - Constants

    enum Constants {
        static let textOffset: (horizontal: CGFloat, vertical: CGFloat) = (32, 16)
        static let valueLabelWidth: CGFloat = 0.3
        static let nameLabelFont = UIFont.systemFont(ofSize: 16, weight: .light)
    }

    // MARK: - Subviews

    private let valueLabel = UILabel()
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
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }

}

// MARK: - Methods

extension PlayerStatCell {

    func configure(model: PlayerStat) {
        nameLabel.text = model.name?.isEmpty == false ? model.name : model.id
        valueLabel.text = model.valueRepresentation
        setNeedsLayout()
    }

}

// MARK: - Private Methods

private extension PlayerStatCell {

    func setupInitialState() {
        configureViews()
        appendSubviews()
    }

    func configureViews() {
        nameLabel.apply {
            $0.textColor = Theme.subText
            $0.font = Constants.nameLabelFont
            $0.numberOfLines = 0
        }

        valueLabel.apply {
            $0.textColor = Theme.mainAccent
            $0.textAlignment = .right
            $0.font = .systemFont(ofSize: 16, weight: .light)
            $0.numberOfLines = 1
        }

        backgroundColor = Theme.subBackground2
    }

}

// MARK: - Private Layout Methods

private extension PlayerStatCell {

    func appendSubviews() {
        add(subviews: valueLabel, nameLabel)
    }

    func layoutViews() {
        valueLabel.pin
            .top(8)
            .right(16)
            .width(30%)
            .sizeToFit(.width)

        nameLabel.pin
            .before(of: valueLabel)
            .left(16)
            .top(8)
            .marginRight(8)
            .sizeToFit(.width)
    }

}

// MARK: - Layout

extension PlayerStatCell {

    static func sizeForCell(model: PlayerStat, width: CGFloat) -> CGSize {
        let labelWidth = width
            - Constants.textOffset.horizontal
            - width * Constants.valueLabelWidth

        let titleHeight = (model.name ?? model.id)
            .height(width: labelWidth, font: Constants.nameLabelFont)

        let height = titleHeight + Constants.textOffset.vertical
        return .init(width: width, height: height)
    }

}
