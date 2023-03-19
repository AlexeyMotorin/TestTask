import UIKit

protocol SignInPagePresenterProtocol: AnyObject {
    var view: SignInPageViewProtocol? { get set}
    var errorAlertModel: ErrorAlertModel? { get }
    func viewDidLoad()
    func checkValidEmail(with email: String?) -> Bool
    func checkProfile(profile: Profile)
}

final class SignInPagePresenter {
    weak var view: SignInPageViewProtocol?
    private let account = AccountStorage.shared
    
    var errorAlertModel: ErrorAlertModel? {
        let tittle = "Такой пользователь уже существует"
        let message = "Повторите попытку"
        let buttonText = "Ok"
        return ErrorAlertModel(title: tittle,
                               message: message,
                               buttonText: buttonText,
                               completion: nil)
    }
    
    private func isValidEmail(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func showpageOneViewController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid configuration")}
        let tabBarVC = TabBarController()
        window.rootViewController = tabBarVC
    }
}

extension SignInPagePresenter: SignInPagePresenterProtocol {
    func checkProfile(profile: Profile) {
        guard profile != account.profile else {
            view?.requestShowErrorAlert(alertModel: errorAlertModel)
            return
        }
        
        account.profile = profile
        showpageOneViewController()
    }
    
    func checkValidEmail(with email: String?) -> Bool {
        if !isValidEmail(email) {
            view?.errorEmailEnter()
            return false
        }
        return true
    }
    
    func viewDidLoad() {
        print("SignInPagePresenter did load")
    }
}
