import UIKit

protocol FriendListAdapterDelegate: class {
    func didSelect(item: Player)
}

final class FriendListAdapter: BaseCollectionAdapter<Player> {

    // MARK: - Properties

    weak var delegate: FriendListAdapterDelegate?
    override var cellTypes: [Cell.Type] { [PlayerCell.self] }

}

// MARK: - UICollectionViewDataSource

extension FriendListAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = generateCell(at: indexPath, type: PlayerCell.self)
        cell.configure(model: items[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(item: items[indexPath.row])
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension FriendListAdapter: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: PlayerCell.Constants.cellHeight)
    }

}
