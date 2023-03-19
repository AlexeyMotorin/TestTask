import Foundation
@testable import TestTask

final class SignInPageViewControllerSpy: SignInPageViewControllerProtocol {
    var signInViewScreen: TestTask.SignInPageViewProtocol?
    var signInCalled = false
    var logInCalled = false
    var signInWith = false
    var account = ""
    
    init(signInViewScreen: TestTask.SignInPageViewProtocol? = SignInPageViewSpy()) {
        self.signInViewScreen = signInViewScreen
    }
    
    func signIn() {
        signInCalled = true
    }
    
    func logIn() {
        logInCalled = true
    }
    
    func signInWith(account: TestTask.SignInWith?) {
        guard let account else { return }
        self.account = account.rawValue
        signInWith = true
    }
    
    func showErrorAlert(alertModel: TestTask.ErrorAlertModel?) {}
}
