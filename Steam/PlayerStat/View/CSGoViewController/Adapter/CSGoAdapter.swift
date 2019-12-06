import UIKit

final class CSGoAdapter: BaseCollectionAdapter<CSGoPlayerStat> {

    // MARK: - Properties

    override var cellTypes: [Cell.Type] {
        [CSGoIconCell.self, CSGoKillDeathCell.self]
    }

    override var items: [CSGoPlayerStat] {
        didSet {
            isKillDeathExist = items.first { $0.statType == .killDeathRate }.isSome
        }
    }

    // MARK: - Private Properties

    private var isKillDeathExist = false

}

// MARK: - UICollectionViewDataSource

extension CSGoAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = items[indexPath.row]

        switch item.statType {
        case .killDeathRate:
            return getKillDeathCell(for: indexPath)
        default:
            return getIconCell(for: indexPath)
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension CSGoAdapter: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let item = items[indexPath.row]

        switch item.statType {
        case .killDeathRate:
            return getKillDeathCellSize()
        default:
            return getIconCellSize()
        }
    }

}

// MARK: - Private Methods

private extension CSGoAdapter {

    func getIconCell(for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = generateCell(at: indexPath, type: CSGoIconCell.self)
        let index = indexPath.row
        let isRight = index.isMultiple(of: 2)
        let isRightAdjusted = isKillDeathExist ? !isRight : isRight
        cell.configure(model: items[index], isRight: isRightAdjusted)
        return cell
    }

    func getKillDeathCell(for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = generateCell(at: indexPath, type: CSGoKillDeathCell.self)
        cell.configure(model: items[indexPath.row])
        return cell
    }

    func getIconCellSize() -> CGSize {
        .init(width: collectionView.frame.width / 2,
              height: CSGoIconCell.Constants.cellHeight)
    }
    
    func getKillDeathCellSize() -> CGSize {
        .init(width: collectionView.frame.width,
              height: CSGoKillDeathCell.Constants.cellHeight)
    }

}
