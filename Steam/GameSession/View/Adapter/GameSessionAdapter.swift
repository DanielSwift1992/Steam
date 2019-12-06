import UIKit

final class GameSessionAdapter: BaseCollectionAdapter<Game> {

    // MARK: - Properties

    override var cellTypes: [Cell.Type] { [RecentlyPlayedCell.self] }

}

// MARK: - UICollectionViewDataSource

extension GameSessionAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = generateCell(at: indexPath, type: RecentlyPlayedCell.self)
        cell.configure(model: items[indexPath.row])
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension GameSessionAdapter: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = items[indexPath.row]
        let width = collectionView.frame.width
        return RecentlyPlayedCell.sizeForCell(model: model, width: width)
    }

}
