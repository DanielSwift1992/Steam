import SnapKit

final public class EmptyStateView: GradientImageView {

    // MARK: Constants

    private enum Constants {
        static let defaultSize: CGFloat = 96
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

    public convenience init(superview: UIView) {
        self.init(frame: .zero)
        appendSubviews(superview)
        setConstraints()
    }

    func set(size: CGFloat) {
        snp.remakeConstraints {
            $0.size.equalTo(size)
        }
    }

}

// MARK: - Methods

public extension EmptyStateView {

    func setVisabilityAnimated(isHidden: Bool, delay: TimeInterval = 0) {
        UIView.animate(withDuration: 0.3, delay: delay, options: [], animations: {
            self.alpha = isHidden ? 0 : 1
        })
    }

}

// MARK: - Piravate Methods

private extension EmptyStateView {

    func setupInitialState() {
        alpha = 0
        image = CommonAsset.EmptyState.noData.image
        set(size: Constants.defaultSize)
    }

}

// MARK: - Layout

private extension EmptyStateView {

    func appendSubviews(_ superview: UIView) {
        superview.addSubview(self)
    }

    func setConstraints() {
        snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
