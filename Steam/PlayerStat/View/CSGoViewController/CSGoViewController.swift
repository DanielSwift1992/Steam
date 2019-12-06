import UIKit

final class CSGoViewController: UIViewController {

    // MARK: - Constants

    enum Constants {
        static let collectionTopInset: CGFloat = 16
    }

    // MARK: - Properties

    var output: PlayerStatViewOutput?

    // MARK: - Subviews

    let spinnerView = SpinnerView()
    var viewsForAnimation: [UIView] { [collectionView] }
    private lazy var emptyStateView = EmptyStateView(superview: view)
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: getFlowLayout())

    private lazy var collectionAdapter = CSGoAdapter(collectionView: collectionView)

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - PlayerStatViewInput

extension CSGoViewController: PlayerStatViewInput {

    func setupInitialState() {
        appendSubviews()
        setConstraints()
        configureViews()
        setInitialStateForSpinnerAnimation()
    }

    func set(playerStat: [PlayerStat]) {
        let statList = CSGoPlayerStatList(playerStat: playerStat)
        collectionAdapter.items = statList.stat
        collectionAdapter.reload()
    }

    func setEmptyState(_ isEmpty: Bool) {
        emptyStateView.setVisabilityAnimated(isHidden: !isEmpty, delay: 0.1)
        collectionView.isHidden = isEmpty
    }

}

// MARK: - Layout

private extension CSGoViewController {

    func configureViews() {
        title = L10n.LocalStat.CSGo.title
        view.backgroundColor = Theme.mainBackground
        collectionView.apply {
            $0.contentInset.top = Constants.collectionTopInset
            $0.backgroundColor = Theme.mainBackground
        }
    }

    func getFlowLayout() -> UICollectionViewLayout {
        UICollectionViewFlowLayout().apply {
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
        }
    }

    func handleContentSizeChange() {
        let delta = collectionView.frame.height
            - collectionView.contentSize.height
        let height = max(delta, 0)
        collectionView.contentInset.top = height / 2
    }

}

// MARK: - Layout

private extension CSGoViewController {

    func appendSubviews() {
        view.add(subviews: collectionView, spinnerView)
    }

    func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            if #available(iOS 11.0, *) {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            } else {
                $0.top.equalToSuperview()
            }
        }

        spinnerView.snp.makeConstraints {
            $0.center.equalTo(collectionView)
        }
    }

}
