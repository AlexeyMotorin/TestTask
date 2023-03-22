import UIKit

protocol LatestCollectionViewPresenterProtocol: AnyObject {
    var view: LatestTableViewCellProtocol? { get set }
    func viewDidLoad()
}

final class LatestCollectionViewPresenter: NSObject {
    weak var view: LatestTableViewCellProtocol?
    private var latestProducts: [ProductCellModel] = LatestService.shared.latests
    private var latestServiceObserver: NSObjectProtocol?
}

extension LatestCollectionViewPresenter: LatestCollectionViewPresenterProtocol {
    func viewDidLoad() {
        latestServiceObserver = NotificationCenter.default
            .addObserver(forName: LatestService.didChangeNotification,
                         object: nil,
                         queue: .main,
                         using: { [weak self] _ in
                guard let self = self else { return }
                self.latestProducts = LatestService.shared.latests
                self.requestUpdateCollectionView()
            })
    }
    
    private func requestUpdateCollectionView() {
        view?.updateCollectionView()
    }
}

extension LatestCollectionViewPresenter: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        latestProducts.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LatestCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? LatestCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        let latestModel = latestProducts[safe: indexPath.row]
        cell.configure(with: latestModel)
        return cell
    }
}

extension LatestCollectionViewPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension LatestCollectionViewPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-40) / 3
        return CGSize(width: width, height: UIScreen.main.bounds.height / 5.4 )
    }
}

