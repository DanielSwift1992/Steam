import SnapKit

protocol ProfileHeaderViewDelegate: class {
    func onStatisticTap()
    func onFriendsTap()
}

final class ProfileHeaderView: UICollectionReusableView {

    // MARK: - Model

    struct Model {
        let steamId: String
        let name: String
        let avatarURL: URL?
        let level: String
        let nextLevelPercent: Double
    }

    // MARK: - Constants

    enum Constants {
        static let animationTime: TimeInterval = 0.3
        static let borderColor = Theme.subText.withAlphaComponent(0.15)
    }

    // MARK: - Properties

    weak var delegate: ProfileHeaderViewDelegate?

    // MARK: - Subviews

    private let levelLabel = UILabel()
    private let profileView = ProfileImageView()
    private let nameLabel = UILabel()
    private let idLabel = UILabel()

    private let friendsButton = UIButton()
    private let statisticButton = UIButton()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Actions

private extension ProfileHeaderView {

    @objc
    func statisticDidTap() {
        delegate?.onStatisticTap()
    }

    @objc
    func friendsDidTap() {
        delegate?.onFriendsTap()
    }

}

// MARK: - Methods

extension ProfileHeaderView {

    func configure(model: Model, delegate: ProfileHeaderViewDelegate?) {
        self.delegate = delegate
        levelLabel.text = model.level
        nameLabel.text = model.name
        idLabel.text = model.steamId
        profileView.imageView.setImage(url: model.avatarURL)
        profileView.set(percent: CGFloat(model.nextLevelPercent),
                        animationDuration: Constants.animationTime)
    }

}

// MARK: - Private Methods

private extension ProfileHeaderView {

    func setupInitialState() {
        configureViews()
        appendSubviews()
        setConstraints()
    }

    func configureViews() {
        levelLabel.apply {
            $0.textColor = Theme.subText
            $0.font = .systemFont(ofSize: 14, weight: .light)
            $0.textAlignment = .center
        }

        nameLabel.apply {
            $0.textColor = Theme.textTitle
            $0.font = .systemFont(ofSize: 34, weight: .light)
            $0.textAlignment = .center
        }

        idLabel.apply {
            $0.textColor = Theme.subText
            $0.font = .systemFont(ofSize: 12, weight: .light)
            $0.textAlignment = .center
        }

        friendsButton.apply {
            $0.setTitle(L10n.Profile.HeaderView.friends, for: .normal)
            $0.setTitleColor(Theme.textTitle, for: .normal)
            $0.setTitleColor(Theme.mainAccent, for: .highlighted)
            $0.addBorder(color: Constants.borderColor, width: 1, to: .top, .bottom)
            $0.addBorder(color: Constants.borderColor, width: 0.5, to: .left, .bottom)
            $0.addTarget(self, action: #selector(friendsDidTap), for: .touchUpInside)
        }

        statisticButton.apply {
            $0.setTitle(L10n.Profile.HeaderView.statistic, for: .normal)
            $0.setTitleColor(Theme.textTitle, for: .normal)
            $0.setTitleColor(Theme.mainAccent, for: .highlighted)
            $0.addBorder(color: Constants.borderColor, width: 1, to: .top, .bottom)
            $0.addBorder(color: Constants.borderColor, width: 0.5, to: .right, .bottom)
            $0.addTarget(self, action: #selector(statisticDidTap), for: .touchUpInside)
        }
    }

}

// MARK: - Layout

private extension ProfileHeaderView {

    func appendSubviews() {
        add(subviews:
            levelLabel,
            profileView,
            nameLabel,
            idLabel,
            friendsButton,
            statisticButton)
    }

    func setConstraints() {
        levelLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }

        profileView.snp.makeConstraints {
            $0.top.equalTo(levelLabel.snp.bottom).offset(8)
            $0.size.height.equalTo(200).priority(.high)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }

        idLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }

        statisticButton.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(16)
            $0.left.bottom.equalToSuperview()
            $0.height.equalTo(68)
        }

        friendsButton.snp.makeConstraints {
            $0.top.equalTo(statisticButton)
            $0.right.equalToSuperview()
            $0.size.equalTo(statisticButton)
            $0.left.equalTo(statisticButton.snp.right)
        }
    }

}
