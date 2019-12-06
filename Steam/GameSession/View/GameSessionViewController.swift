import UIKit

final class GameSessionViewController: UIViewController {

    // MARK: - Properties

    var output: GameSessionViewOutput?
    var viewsForAnimation: [UIView] { [collectionView] }

    // MARK: - Private Properties

    private lazy var collectionAdapter = GameSessionAdapter(collectionView: collectionView)

    // MARK: - Subviews

    let spinnerView = SpinnerView()
    private lazy var emptyStateView = EmptyStateView(superview: view)
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: getFlowLayout())

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        spinnerView.restoreAnimationIfNeeded()
    }

}

// MARK: - GameSessionViewInput

extension GameSessionViewController: GameSessionViewInput {

    func setupInitialState() {
        appendSubviews()
        setConstraints()
        configureViews()
        setInitialStateForSpinnerAnimation()
    }

    func set(games: [Game]) {
        collectionAdapter.items = games
        collectionAdapter.reload()
    }

    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.removeTheShadow()
        parent?.navigationItem.title = L10n.GameSession.title
    }

    func setEmptyState(_ isEmpty: Bool) {
        emptyStateView.setVisabilityAnimated(isHidden: !isEmpty, delay: 0.1)
        collectionView.isHidden = isEmpty
    }

}

// MARK: - Private Methods

extension GameSessionViewController {

    func getFlowLayout() -> UICollectionViewLayout {
        UICollectionViewFlowLayout().apply {
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
        }
    }

    func configureViews() {
        collectionView.apply {
            $0.alpha = 0
            $0.backgroundColor = Theme.mainBackground
            $0.contentInset.top = 20
        }

        view.backgroundColor = Theme.mainBackground
    }

}

// MARK: - Layout

private extension GameSessionViewController {

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
