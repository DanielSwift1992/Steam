import PinLayout

final class CSGoKillDeathCell: UICollectionViewCell {

    // MARK: - Constants

    enum Constants {
        static let cellHeight: CGFloat = 100
    }

    // MARK: - Subviews

    private let textContainerView = UIView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

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

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }

}

// MARK: - Methods

extension CSGoKillDeathCell {

    func configure(model: CSGoPlayerStat) {
        titleLabel.text = model.statType.text
        valueLabel.text = model.value
        setNeedsLayout()
    }

}

// MARK: - Private Methods

private extension CSGoKillDeathCell {

    func setupInitialState() {
        configureViews()
        appendSubviews()
    }

    func configureViews() {
        titleLabel.apply {
            $0.font = .systemFont(ofSize: 18, weight: .light)
            $0.numberOfLines = 1
            $0.textColor = Theme.subText
            $0.textAlignment = .center
        }

        valueLabel.apply {
            $0.font = .systemFont(ofSize: 36, weight: .light)
            $0.numberOfLines = 1
            $0.textColor = Theme.mainAccent
            $0.textAlignment = .center
        }

        backgroundColor = .clear
    }

}

// MARK: - Layout

private extension CSGoKillDeathCell {

    func appendSubviews() {
        add(subviews: textContainerView.add(subviews: titleLabel, valueLabel))
    }

    func layoutViews() {
        textContainerView.pin
            .all()

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
