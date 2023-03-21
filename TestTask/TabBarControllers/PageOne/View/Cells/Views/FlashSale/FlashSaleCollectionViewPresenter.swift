import UIKit

protocol FlashSaleCollectionViewPresenterProtocol: AnyObject {
    var view: FlashSaleTableViewCellProtocol? { get set }
}

final class FlashSaleCollectionViewPresenter: NSObject {
    weak var view: FlashSaleTableViewCellProtocol?
    private var flashSaleProducts: [FlashSaleProductModel] = []
}

extension FlashSaleCollectionViewPresenter: FlashSaleCollectionViewPresenterProtocol {
    
}

extension FlashSaleCollectionViewPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // latestProducts.count
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashSaleCollectionViewCell.reuseIdentifier, for: indexPath) as? FlashSaleCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
//        let latestModel = latestProducts[indexPath.row]
//        cell.configure(with: latestModel)
            
        return cell
    
    }
}

extension FlashSaleCollectionViewPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension FlashSaleCollectionViewPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
    
        return CGSize(width: width, height: UIScreen.main.bounds.height / 3.7 )
    }
}

