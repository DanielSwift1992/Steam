import UIKit

final class PlayerStatViewController: UIViewController {

    // MARK: - Properties

    var output: PlayerStatViewOutput?

    // MARK: - Subviews

    let spinnerView = SpinnerView()
    var viewsForAnimation: [UIView] { [collectionView] }
    private lazy var emptyStateView = EmptyStateView(superview: view)
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: getFlowLayout())

    private lazy var collectionAdapter = PlayerStatAdapter(collectionView: collectionView)

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - PlayerStatViewInput

extension PlayerStatViewController: PlayerStatViewInput {

    func setupInitialState() {
        appendSubviews()
        setConstraints()
        configureViews()
        setInitialStateForSpinnerAnimation()
    }

    func set(playerStat: [PlayerStat]) {
        collectionAdapter.items = playerStat
        collectionAdapter.reload()
    }

    func setEmptyState(_ isEmpty: Bool) {
        emptyStateView.setVisabilityAnimated(isHidden: !isEmpty, delay: 0.1)
        collectionView.isHidden = isEmpty
    }

}

// MARK: - Private Methods

private extension PlayerStatViewController {

    func configureViews() {
        view.backgroundColor = Theme.mainBackground
        collectionView.backgroundColor = Theme.mainBackground
        title = L10n.LocalStat.title
    }

    func getFlowLayout() -> UICollectionViewLayout {
        UICollectionViewFlowLayout().apply {
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
        }
    }

}

// MARK: - Layout

private extension PlayerStatViewController {

    func appendSubviews() {
        view.add(subviews: collectionView, spinnerView)
    }

    func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }

        spinnerView.snp.makeConstraints {
            $0.center.equalTo(collectionView)
        }
    }

}
