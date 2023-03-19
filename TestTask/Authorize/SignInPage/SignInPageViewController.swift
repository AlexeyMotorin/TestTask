
import UIKit

protocol SignInPageViewControllerProtocol: AnyObject {
    func signIn()
    func logIn()
    func signInWith(account: SignInWith?)
    func showErrorAlert(alertModel: ErrorAlertModel?)
}

/// Класс отвечает за отображение начального экрана авторизации
final class SignInPageViewController: UIViewController {

    private var signInPageView: SignInPageView!
    private var errorAlertPresenter: ErrorAlertPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        
        // Подразумевается что аккаунт уже есть, сохраняем его первом запуске
        creatAccount()
    }
    
    private func creatAccount() {
        
        let firstCalledApp =  UserDefaults.standard.bool(forKey: "firstCalledApp")
        guard !firstCalledApp else { return }
        
        let profile = Profile(
            firstName: "Satria Adhi",
            lastName: "Pradana",
            email: "Satria@pradana.com",
            balance: 1593,
            profileImage: "ProfileImage"
        )
        let password = "1234"
        
        AccountStorage.shared.profile = profile
        AccountStorage.shared.password = password
        
        UserDefaults.standard.set(true, forKey: "firstCalledApp")
    }
    
    private func setupViewController() {
        signInPageView = SignInPageView(frame: view.bounds, viewController: self)
        addScreenView(view: signInPageView)
        errorAlertPresenter = ErrorAlertPresenter(delegate: self)
        view.backgroundColor = .systemBackground
    }
    
    private func showLoginController() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
    
    deinit {
        print("deinit SignInPageViewController")
    }
}

extension SignInPageViewController: SignInPageViewControllerProtocol {
    func showErrorAlert(alertModel: ErrorAlertModel?) {
        guard let alertModel else { return }
        errorAlertPresenter?.requestShowResultAlert(alertModel: alertModel)
    }
    
    func signInWith(account: SignInWith?) {
        guard let account else { return }
        print("Sign in with \(account.rawValue)")
    }
    
    func signInWith() {
        print("sign In")
    }
    
    func signIn() {
        print("sign In")
    }
    
    func logIn() {
        showLoginController()
    }
}

extension SignInPageViewController: ErrorAlertPresenterDelegate {
    func showErrorAlert(alertController: UIAlertController?) {
        guard let alertController = alertController else { return }
        present(alertController, animated: true)
    }
}
