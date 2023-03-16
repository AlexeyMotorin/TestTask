import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func dismissVC()
}

final class LoginViewController: UIViewController {
    
    private var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        loginView = LoginView(frame: view.bounds, viewController: self)
        addScreenView(view: loginView)
        view.backgroundColor = .systemBackground
    }
    
    deinit {
        print("Deinit LoginViewController")
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    func dismissVC() {
        dismiss(animated: true)
    }
    
    
}

