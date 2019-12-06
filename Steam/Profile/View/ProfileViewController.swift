import UIKit
import PinLayout

final class ProfileViewController: UIViewController {

    // MARK: - Properties

    var output: ProfileViewOutput?

    // MARK: - Private Properties

    private lazy var collectionAdapter = ProfileAdapter(collectionView: collectionView)

    // MARK: - Subviews

    let spinnerView = SpinnerView()
    var viewsForAnimation: [UIView] { [collectionView] }
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

// MARK: - ProfileViewInput

extension ProfileViewController: ProfileViewInput {

    func setupInitialState() {
        appendSubviews()
        setConstraints()
        configureViews()
        setDelegates()
        setInitialStateForSpinnerAnimation()
    }

    func set(headerModel: ProfileHeaderView.Model, games: [Game]) {
        collectionAdapter.apply {
            $0.headerDelegate = output
            $0.headerModel = headerModel
            $0.items = games
            $0.reload()
        }

        setEmptyState(headerModel.name.isEmpty && games.isEmpty)
    }

    func configureNavigationBar() {
        navigationController?.apply {
            $0.setNavigationBarHidden(false, animated: true)
            $0.removeTheShadow()
        }

        [parent?.navigationItem, navigationItem].forEach {
            $0?.title = L10n.Profile.title
            $0?.backBarButtonItem = .init(title: "",
                                         style: .plain,
                                         target: nil,
                                         action: nil)
        }
    }

    func setEmptyState(_ isEmpty: Bool) {
        emptyStateView.setVisabilityAnimated(isHidden: !isEmpty, delay: 0.1)
        collectionView.isHidden = isEmpty
    }

}

// MARK: - Private Methods

private extension ProfileViewController {

    func getFlowLayout() -> UICollectionViewLayout {
        UICollectionViewFlowLayout().apply {
            $0.minimumLineSpacing = 2
            $0.minimumInteritemSpacing = 0
        }
    }

    func setDelegates() {
        collectionAdapter.delegate = output
    }

    func configureViews() {
        collectionView.apply {
            $0.alpha = 0
            $0.backgroundColor = Theme.mainBackground
        }

        view.backgroundColor = Theme.mainBackground
    }

}


// MARK: - Layout

private extension ProfileViewController {

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
