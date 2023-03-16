import Foundation

protocol SignInPagePresenterProtocol: AnyObject {
    var view: SignInPageViewProtocol? { get set}
    func viewDidLoad()
}

final class SignInPagePresenter {
    weak var view: SignInPageViewProtocol?
}

extension SignInPagePresenter: SignInPagePresenterProtocol {
    func viewDidLoad() {
        print("Вызываю did load")
    }
}
