import UIKit

open class BaseCollectionAdapter<Model>: NSObject {

    // MARK: - Typealias

    public typealias Cell = UICollectionViewCell
    public typealias Supplementary = UICollectionReusableView

    // MARK: - Properties

    open var cellTypes: [Cell.Type] { [] }
    open var supplementaryTypes: [String: Supplementary.Type] { [:] }
    open var items: [Model] = []
    public let collectionView: UICollectionView

    // MARK: - Initialization

    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.delegate = self as? UICollectionViewDelegate
        registerClasses()
    }

    // MARK: - Methods

    open func reload() {
        collectionView.reloadData()
    }

    open func generateCell<T: Cell>(at indexPath: IndexPath, type: T.Type) -> T {
        collectionView.dequeueReusableCell(withReuseIdentifier: type.nameOfClass,
        for: indexPath) as? T ?? .init()
    }

    open func generateSupplementary<T: Supplementary>(at indexPath: IndexPath,
                                                      type: T.Type, ofKind: String) -> T {
        collectionView
            .dequeueReusableSupplementaryView(ofKind: ofKind,
                                              withReuseIdentifier: type.nameOfClass,
                                              for: indexPath) as? T ?? .init()
    }

    // MARK: - Private Methods

    private func registerClasses() {
        cellTypes.forEach {
            collectionView.register($0, forCellWithReuseIdentifier: $0.nameOfClass)
        }

        supplementaryTypes.forEach {
            collectionView.register($0.1,
                                    forSupplementaryViewOfKind: $0.0,
                                    withReuseIdentifier: $0.1.nameOfClass)
        }
    }

}
