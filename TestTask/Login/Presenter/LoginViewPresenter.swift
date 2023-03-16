import Foundation

protocol LoginViewPresenterProtocol: AnyObject {
    var view: LoginViewProtocol? { get set}
    func viewDidLoad()
    func showPassword()
}

final class LoginViewPresenter {
    weak var view: LoginViewProtocol?
    
    private var iconPasswordButtonClick = true
    
    private func checkIconPasswordButtonClick() {
        iconPasswordButtonClick ? view?.setSecureTextEntry(false) : view?.setSecureTextEntry(true)
        iconPasswordButtonClick = !iconPasswordButtonClick
    }
}

extension LoginViewPresenter: LoginViewPresenterProtocol {
    func viewDidLoad() {
        print("Login view did load")
    }
    
    func showPassword() {
        checkIconPasswordButtonClick()
    }
}
