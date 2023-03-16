import Foundation

protocol SignInPagePresenterProtocol: AnyObject {
    var view: SignInPageViewProtocol? { get set}
    func viewDidLoad()
    func checkValidEmail(with email: String?) -> Bool
}

final class SignInPagePresenter {
    weak var view: SignInPageViewProtocol?
    
    private func isValidEmail(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension SignInPagePresenter: SignInPagePresenterProtocol {
    func checkValidEmail(with email: String?) -> Bool {
        if !isValidEmail(email) {
            view?.errorEmailEnter()
            return false
        }
        return true
    }
    
    func viewDidLoad() {
        print("Вызываю did load")
    }
}
