import UIKit

protocol ProfilePresenterProtocol: AnyObject {
    var view: ProfileViewProtocol? { get set}
    var profile: Profile? { get }
    func viewDidLoad()
}

final class ProfilePresenter: NSObject {
    weak var view: ProfileViewProtocol?
    let profile = AccountStorage.shared.profile
    
    let cellTypes: [CellType] = [
        CellType(typeCell: .tradeStore, title: "Trade store"),
        CellType(typeCell: .paymentMethods, title: "Payment method"),
        CellType(typeCell: .balance, title: "Balance", balance: AccountStorage.shared.profile?.balance),
        CellType(typeCell: .tradeHistory, title: "Trade history"),
        CellType(typeCell: .restore, title: "Restore Purchase"),
        CellType(typeCell: .help, title: "Help"),
        CellType(typeCell: .logOut, title: "Log out"),
    ]
    
    var logoutAlertModel: LogoutAlertModel {
        let alertModel = LogoutAlertModel(
            title: "Выход из аккаунта",
            message: "Уверены, что хотите выйти?",
            buttonText: "Да") { [weak self] _ in
                guard let self = self else { return }
                
                AccountStorage.shared.removeAccount()
                self.cleanCookies()
                self.showSignInViewController()
            }
        return alertModel
    }
    
    private func showSignInViewController() {
        guard let window = UIApplication.shared.windows.first else {
            fatalError("Invalid configuration")
        }
        let signInVC = SignInPageViewController()
        window.rootViewController = signInVC
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func viewDidLoad() {
        print("Profile view did load")
    }
}

extension ProfilePresenter: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let cellType = cellTypes[indexPath.row]
        
        switch cellType.typeCell {
        case .tradeStore:
            print("Show tradeStore")
        case .paymentMethods:
            print("Show paymentMethods")
        case .balance:
            print("Show balance")
        case .tradeHistory:
            print("Show tradeHistory")
        case .restore:
            print("Show restore")
        case .help:
            print("Show help")
        case .logOut:
            view?.viewController?.logoutProfile(alertModel: logoutAlertModel)
        }
    }
    
    private func cleanCookies() {
        print("Почистити куки")
    }
}

extension ProfilePresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageURL = profile?.profileImage
        let profileName = profile?.fullName
        let view = AvatarInfoView(frame: UIScreen.main.bounds, imageURL: imageURL , profileName: profileName)
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height / 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height / 15
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let profileSettingsCell = tableView.dequeueReusableCell(
                withIdentifier: ProfileSettingsCell.reuseIdentifier,
                for: indexPath) as? ProfileSettingsCell else {
            return UITableViewCell()
        }
        profileSettingsCell.selectionStyle = .none
        
        let cellType = cellTypes[indexPath.row]
        profileSettingsCell.config(typeCell: cellType)
        
        return profileSettingsCell
    }
}

extension ProfilePresenter: AvatarInfoViewDelegate {
    func showViewController(_ viewController: UIViewController) {
        view?.viewController?.showViewController(viewController: viewController)
    }
    
    func dismissImagePicker() {
        view?.viewController?.dismissViewController()
    }
}
