import UIKit

protocol PageOneViewProtocol: AnyObject {
    var presenter: PageOnePresenterProtocol? { get set }
    var viewController: PageOneViewControllerProtocol? { get set }
}

final class PageOneView: UIView {
    var presenter: PageOnePresenterProtocol?
    weak var viewController: PageOneViewControllerProtocol?
    
    
   
    private var searchBar: UISearchBar!

    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = .clear
       
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        tableView.register(LatestTableViewCell.self, forCellReuseIdentifier: LatestTableViewCell.reuseIdentifier)
        tableView.register(FlashSaleTableViewCell.self, forCellReuseIdentifier: FlashSaleTableViewCell.reuseIdentifier)
        tableView.register(BrandsTableViewCell.self, forCellReuseIdentifier: BrandsTableViewCell.reuseIdentifier)        
        return tableView
    }()
    
    init(frame: CGRect, viewController: PageOneViewControllerProtocol) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.viewController = viewController
        presenter = PageOnePresenter()
        presenter?.view = self
        presenter?.viewDidLoad()
        tableView.delegate = presenter as? PageOnePresenter
        tableView.dataSource = presenter as? PageOnePresenter
        setuView()
        

    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setuView() {
        backgroundColor = .ttBackgroundColor
        addSubviews()
        activateConstraints()
    }
    
    private func addSubviews() {
        addSubview(tableView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension PageOneView: PageOneViewProtocol {}
