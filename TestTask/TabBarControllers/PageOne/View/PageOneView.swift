import UIKit

protocol PageOneViewProtocol: AnyObject {
    var presenter: PageOnePresenterProtocol? { get set }
    var viewController: PageOneViewControllerProtocol? { get set }
    
    func showTableView()
}

final class PageOneView: UIView {
    var presenter: PageOnePresenterProtocol?
    weak var viewController: PageOneViewControllerProtocol?
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = .clear
        tableView.isHidden = true
        tableView.alpha = 0
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
        spinner.startAnimating()
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
        addSubviews(spinner, tableView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension PageOneView: PageOneViewProtocol {
    func showTableView() {
        spinner.stopAnimating()
        tableView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.tableView.alpha = 1
        }
    }
}
