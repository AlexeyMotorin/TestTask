import UIKit

protocol FlashSaleCollectionViewPresenterProtocol: AnyObject {
    var view: FlashSaleTableViewCellProtocol? { get set }
    func viewDidLoad()
}

final class FlashSaleCollectionViewPresenter: NSObject {
    weak var view: FlashSaleTableViewCellProtocol?
    private var flashSaleServiceObserver: NSObjectProtocol?
    private var flashSaleProducts: [ProducCelltModel] = FlashSaleService.shared.flashSaleProducts
}

extension FlashSaleCollectionViewPresenter: FlashSaleCollectionViewPresenterProtocol {
    func viewDidLoad() {
        flashSaleServiceObserver = NotificationCenter.default
            .addObserver(forName: FlashSaleService.didChangeNotification,
                         object: nil,
                         queue: .main,
                         using: { [weak self] _ in
                guard let self = self else { return }
                self.flashSaleProducts = FlashSaleService.shared.flashSaleProducts
                self.requestUpdateCollectionView()
            })
    }
    
    private func requestUpdateCollectionView() {
        view?.requestUpdateCollectionView()
    }
}

extension FlashSaleCollectionViewPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        flashSaleProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashSaleCollectionViewCell.reuseIdentifier, for: indexPath) as? FlashSaleCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        let latestModel = flashSaleProducts[safe: indexPath.row]
        cell.configure(with: latestModel)
            
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

