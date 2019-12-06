import UIKit

final class FriendListViewController: UIViewController {

    // MARK: - Properties

    var output: FriendListViewOutput?

    // MARK: - Subviews

    let spinnerView = SpinnerView()
    var viewsForAnimation: [UIView] { [collectionView] }
    private lazy var emptyStateView = EmptyStateView(superview: view)
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: getFlowLayout())

    private lazy var collectionAdapter = FriendListAdapter(collectionView: collectionView)

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - FriendListViewInput

extension FriendListViewController: FriendListViewInput {

    func setupInitialState() {
        appendSubviews()
        setConstraints()
        setDelegates()
        configureViews()
        configureNavigationBar()
        setInitialStateForSpinnerAnimation()
    }

    func set(friends: [Player]) {
        collectionAdapter.items = friends
        collectionAdapter.reload()
    }

    func setEmptyState(_ isEmpty: Bool) {
        emptyStateView.setVisabilityAnimated(isHidden: !isEmpty, delay: 0.1)
        collectionView.isHidden = isEmpty
    }

}

// MARK: - Private Methods

private extension FriendListViewController {

    func getFlowLayout() -> UICollectionViewLayout {
        UICollectionViewFlowLayout().apply {
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
        }
    }

    func setDelegates() {
        collectionAdapter.delegate = output
    }

    func configureViews() {
        view.backgroundColor = Theme.mainBackground
        collectionView.backgroundColor = Theme.mainBackground
        title = L10n.Friends.title
    }

    func configureNavigationBar() {
        navigationItem.backBarButtonItem = .init(title: "",
                                                 style: .plain,
                                                 target: nil,
                                                 action: nil)
    }

}

// MARK: - Layout

private extension FriendListViewController {

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
