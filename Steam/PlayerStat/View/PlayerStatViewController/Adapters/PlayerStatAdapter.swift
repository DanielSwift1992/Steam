import UIKit

protocol PlayerStatAdapterDelegate: class {
    func didSelect(item: PlayerStat)
}

final class PlayerStatAdapter: BaseCollectionAdapter<PlayerStat> {

    // MARK: - Properties

    weak var delegate: PlayerStatAdapterDelegate?
    override var cellTypes: [Cell.Type] { [PlayerStatCell.self] }

}

// MARK: - UICollectionViewDataSource

extension PlayerStatAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = generateCell(at: indexPath, type: PlayerStatCell.self)
        cell.configure(model: items[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(item: items[indexPath.row])
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension PlayerStatAdapter: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = items[indexPath.row]
        let width = collectionView.frame.width
        return PlayerStatCell.sizeForCell(model: model, width: width)
    }

}
