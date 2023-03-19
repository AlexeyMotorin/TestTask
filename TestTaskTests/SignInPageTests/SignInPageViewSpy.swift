import Foundation
@testable import TestTask

final class SignInPageViewSpy: SignInPageViewProtocol {
    var viewController: TestTask.SignInPageViewControllerProtocol?
    
    var presenter: TestTask.SignInPagePresenterProtocol?
    
    func errorEmailEnter() {}
    
    func logInButtonTapped() {
        viewController?.logIn()
    }
   
    func signInButtonTapped() {
        viewController?.signIn()
    }
    
    func signInWith(with account: SignInWith) {
        viewController?.signInWith(account: account)
    }
    
    func requestShowErrorAlert(alertModel: TestTask.ErrorAlertModel?) {}
}

