import UIKit

protocol ProfileAdapterDelegate: class {
    func didSelect(item: Game)
}

final class ProfileAdapter: BaseCollectionAdapter<Game> {

    // MARK: - Typealias

    typealias Header = ProfileHeaderView

    // MARK: - Constants

    private enum Constants {
        static let headerType = UICollectionView.elementKindSectionHeader
    }

    // MARK: - Properties

    weak var delegate: ProfileAdapterDelegate?
    var headerModel: Header.Model?
    var headerDelegate: ProfileHeaderViewDelegate?

    override var cellTypes: [Cell.Type] { [GameCell.self] }
    override var supplementaryTypes: [String: Supplementary.Type] {
        [UICollectionView.elementKindSectionHeader: Header.self]
    }

    // MARK: - Pivate Properties

    private lazy var headerView = generateHeader()

    // MARK: - Methods

    override func reload() {
        configureHeader()
        collectionView.reloadData()
    }

}

// MARK: - UICollectionViewDataSource

extension ProfileAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard case Constants.headerType = kind else {
            return .init()
        }
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = generateCell(at: indexPath, type: GameCell.self)
        cell.configure(model: items[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(item: items[indexPath.row])
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileAdapter: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: GameCell.Constants.cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        headerView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
    }

}

// MARK: - Private methods

extension ProfileAdapter {

    func generateHeader() -> Header {
        generateSupplementary(at: .zero,
                                     type: Header.self,
                                     ofKind: Constants.headerType)
    }

    func configureHeader() {
        guard let headerModel = headerModel else { return  }
        headerView.configure(model: headerModel, delegate: headerDelegate)
    }

}
