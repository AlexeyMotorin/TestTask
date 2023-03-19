import Foundation
@testable import TestTask

final class SignInPagePresenterSpy: SignInPagePresenterProtocol {
    
    var errorAlertModel: TestTask.ErrorAlertModel?
    
    func checkProfile(profile: TestTask.Profile) {}
    
    
    var view: SignInPageViewProtocol?
    
    var viewDidLoadCalled = false
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func checkValidEmail(with email: String?) -> Bool {
        return false
    }
}
