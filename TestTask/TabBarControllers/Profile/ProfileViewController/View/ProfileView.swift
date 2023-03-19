import UIKit

protocol ProfileViewProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    var viewController: ProfileViewControllerProtocol? { get set }
}

final class ProfileView: UIView {
    var presenter: ProfilePresenterProtocol?
    weak var viewController: ProfileViewControllerProtocol?
    
    private enum Constants {
        static let backButtonImageName = "BackButton"
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Constants.backButtonImageName), for: .normal)
        button.addTarget(self, action: #selector(didBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = .ttBackgroundColor
        tableView.register(ProfileSettingsCell.self, forCellReuseIdentifier: ProfileSettingsCell.reuseIdentifier)
        return tableView
    }()
        
    init(frame: CGRect, viewController: ProfileViewControllerProtocol) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.viewController = viewController
        presenter = ProfilePresenter()
        presenter?.view = self
        presenter?.viewDidLoad()
        tableView.delegate = presenter as? ProfilePresenter
        tableView.dataSource = presenter as? ProfilePresenter
        setuView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setuView() {
        backgroundColor = .red
        addSubviews()
        activateConstraints()
    }
    
    private func addSubviews() {
        addSubviews(tableView, backButton)
    }
    
    private func activateConstraints() {
        let backButtonWidth: CGFloat = 44
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: backButtonWidth),
            backButton.heightAnchor.constraint(equalToConstant: backButtonWidth),
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: frame.height / 15),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    @objc private func didBackButtonTapped() {
        print("Сработала кнопка назад")
    }
}

extension ProfileView: ProfileViewProtocol {}


