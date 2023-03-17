import XCTest
@testable import TestTask

final class SignInPageTest: XCTestCase {

    func testViewControllerCallsDidLoad() {
        let sut = SignInPageViewControllerSpy()
        let presenter = SignInPagePresenterSpy()
        
        guard let view = sut.signInViewScreen as? SignInPageViewSpy else {
            XCTFail()
            return
        }
        
        view.presenter = presenter
        view.presenter?.view = view
        presenter.viewDidLoad()
        
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testCallsLogInSignInAndSignInWith() {
        let sut = SignInPageViewControllerSpy()
       
        guard let view = sut.signInViewScreen as? SignInPageViewSpy else {
            XCTFail()
            return
        }
        
        view.viewController = sut
        
        view.logInButtonTapped()
        XCTAssertTrue(sut.logInCalled)
        
        view.signInButtonTapped()
        XCTAssertTrue(sut.logInCalled)
        
        let appleAccount: SignInWith = .apple
        view.signInWith(with: appleAccount)
        XCTAssertTrue(sut.logInCalled)
        XCTAssertEqual(appleAccount.rawValue, sut.account)
    }
    
    func testValidEmailFalls() {
        let presenter = SignInPagePresenter()
        let email = "123123"
        
        let validEmail = presenter.checkValidEmail(with: email)
        XCTAssertFalse(validEmail)
    }
    
    func testValidEmailTrue() {
        let presenter = SignInPagePresenter()
        let email = "123@mail.com"
        
        let validEmail = presenter.checkValidEmail(with: email)
        XCTAssertTrue(validEmail)
    }
}
