import UIKit

protocol ProfileViewControllerProtocol: AnyObject {
    func showViewController(viewController: UIViewController)
    func dismissViewController()
    func logoutProfile(alertModel: LogoutAlertModel)
}

class ProfileViewController: UIViewController {

    var profileView: ProfileView!
    private var logoutAlertPresenter: LogoutAlertPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .ttBackgroundColor
        profileView = ProfileView(frame: view.bounds, viewController: self)
        logoutAlertPresenter = LogoutAlertPresenter(delegate: self)
        addScreenView(view: profileView)
    }
    
    deinit {
        print("deinit ProfileViewController")
    }
}

extension ProfileViewController: ProfileViewControllerProtocol {
    func logoutProfile(alertModel: LogoutAlertModel) {
        logoutAlertPresenter?.requestShowLogoutAlert(alertModel: alertModel)
    }
    
    func showViewController(viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func dismissViewController() {
        dismiss(animated: true)
    }
}

extension ProfileViewController: LogoutAlertPresenterDelegate {
    func showLogoutAlert(alertController: UIAlertController?) {
        guard let alertController = alertController else { return }
        present(alertController, animated: true)
    }
}
