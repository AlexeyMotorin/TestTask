import UIKit

protocol PageOnePresenterProtocol: AnyObject {
    var view: PageOneViewProtocol? { get set}
    func viewDidLoad()
}

final class PageOnePresenter: NSObject {
    weak var view: PageOneViewProtocol?
}

extension PageOnePresenter: PageOnePresenterProtocol {
    func viewDidLoad() {
        print("PageOnePresenter did load")
    }
}

extension PageOnePresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       100
    }
}

extension PageOnePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            cell = creatCategoryCell(tableView, indexPath: indexPath)
        case 1:
            cell = creatLatestTableViewCell(tableView, indexPath: indexPath)
        case 2:
            cell = creatFlashSaleTableViewCell(tableView, indexPath: indexPath)
        case 3:
            cell = creatBrandsTableViewCell(tableView, indexPath: indexPath)
        default:
           break
        }
        
        return cell
    }
        
    private func creatLatestTableViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LatestTableViewCell.reuseIdentifier, for: indexPath) as? LatestTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
    private func creatCategoryCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    private func creatFlashSaleTableViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlashSaleTableViewCell.reuseIdentifier, for: indexPath) as? FlashSaleTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    private func creatBrandsTableViewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BrandsTableViewCell.reuseIdentifier, for: indexPath) as? BrandsTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
    
}
