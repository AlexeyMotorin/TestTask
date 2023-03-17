import UIKit

protocol LoginViewPresenterProtocol: AnyObject {
    var view: LoginViewProtocol? { get set}
    var errorAlertModel: ErrorAlertModel { get }
    func viewDidLoad()
    func showPassword()
    func checkAccount(with firstName: String?, and password: String?)
}

final class LoginViewPresenter {
    weak var view: LoginViewProtocol?
    
    var errorAlertModel: ErrorAlertModel {
        let tittle = "Неверный логин или пароль"
        let message = "Повторите попытку"
        let buttonText = "Ok"
        return ErrorAlertModel(title: tittle,
                               message: message,
                               buttonText: buttonText,
                               completion: nil)
    }
    
    
    private var iconPasswordButtonClick = true
    private let account = AccountStorage.shared
    
    private func checkIconPasswordButtonClick() {
        iconPasswordButtonClick ? view?.setSecureTextEntry(false) : view?.setSecureTextEntry(true)
        iconPasswordButtonClick = !iconPasswordButtonClick
    }
    
    private func showpageOneViewController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid configuration")}
        let tabBarVC = TabBarController()
        window.rootViewController = tabBarVC
    }
}

extension LoginViewPresenter: LoginViewPresenterProtocol {
    func checkAccount(with firstName: String?, and password: String?) {
        guard
            firstName == account.profile?.firstName,
            password == account.password
        else {
            view?.requestShowErrorAlert(alertModel: errorAlertModel)
            return
        }
        
        showpageOneViewController()
    }
    
    
    func viewDidLoad() {
        print("Login view did load")
    }
    
    func showPassword() {
        checkIconPasswordButtonClick()
    }
}

