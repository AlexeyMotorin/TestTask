import UIKit

protocol LatestCollectionViewPresenterProtocol: AnyObject {
    var view: LatestTableViewCellProtocol? { get set }
}

final class LatestCollectionViewPresenter: NSObject {
    weak var view: LatestTableViewCellProtocol?
    private var latestProducts: [LatestProductModel] = []
}

extension LatestCollectionViewPresenter: LatestCollectionViewPresenterProtocol {}

extension LatestCollectionViewPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // latestProducts.count
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCollectionViewCell.reuseIdentifier, for: indexPath) as? LatestCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
//        let latestModel = latestProducts[indexPath.row]
//        cell.configure(with: latestModel)
            
        return cell
    
    }
}

extension LatestCollectionViewPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension LatestCollectionViewPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-40) / 3
        return CGSize(width: width, height: UIScreen.main.bounds.height / 5.4 )
    }
}

