import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func showPage1()
    func showErrorAlert(alertModel: ErrorAlertModel)
}

final class LoginViewController: UIViewController {
    
    private var loginView: LoginView!
    private var errorAlertPresenter: ErrorAlertPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        loginView = LoginView(frame: view.bounds, viewController: self)
        errorAlertPresenter = ErrorAlertPresenter(delegate: self)
        addScreenView(view: loginView)
        view.backgroundColor = .systemBackground
                
        // Подразумевается что аккаунт уже есть, сохраняем его первом запуске
        creatAccount()
    }
    
    private func creatAccount() {
        
        let firstCalledApp =  UserDefaults.standard.bool(forKey: "firstCalledApp")
        guard !firstCalledApp else { return }
        
        let profile = Profile(firstName: "Satria Adhi", lastName: "Pradana", email: "Satria@pradana.com")
        let password = "1234"
        
        AccountStorage.shared.profile = profile
        AccountStorage.shared.password = password
        
        UserDefaults.standard.set(true, forKey: "firstCalledApp")
    }
    
    deinit {
        print("Deinit LoginViewController")
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    func showErrorAlert(alertModel: ErrorAlertModel) {
        errorAlertPresenter?.requestShowResultAlert(alertModel: alertModel)
    }
    
    func showPage1() {
        print("Show page 1")
    }
}

extension LoginViewController: ErrorAlertPresenterDelegate {
    func showErrorAlert(alertController: UIAlertController?) {
        guard let alertController = alertController else { return }
        present(alertController, animated: true)
    }
}

