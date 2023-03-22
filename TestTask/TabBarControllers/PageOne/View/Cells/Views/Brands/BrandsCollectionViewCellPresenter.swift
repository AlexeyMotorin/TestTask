import UIKit

protocol BrandsCollectionViewCellPresenterProtocol: AnyObject {
    var view: BrandsTableViewCellProtocol? { get set }
    func viewDidLoad()
}

final class BrandsCollectionViewCellPresenter: NSObject {
    weak var view: BrandsTableViewCellProtocol?
    private var brands = [
        "Adidas",
        "Nike",
        "Reebok",
        "Puma"
    ]
}

extension BrandsCollectionViewCellPresenter: BrandsCollectionViewCellPresenterProtocol {
    func viewDidLoad() {}
}

extension BrandsCollectionViewCellPresenter: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        brands.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BrandCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? BrandCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let brand = brands[safe: indexPath.row]
        cell.configure(with: brand)
        return cell
    }
}

extension BrandsCollectionViewCellPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension BrandsCollectionViewCellPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let bounds = UIScreen.main.bounds
         let width = (bounds.width-40) / 3
         return CGSize(width: width, height: UIScreen.main.bounds.height / 5.4 )
    }
}

