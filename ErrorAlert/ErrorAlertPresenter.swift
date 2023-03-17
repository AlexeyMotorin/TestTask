import UIKit

protocol ErrorAlertPresenterProtocol: AnyObject {
    func requestShowResultAlert(alertModel: ErrorAlertModel?)
}

protocol ErrorAlertPresenterDelegate: AnyObject {
    func showErrorAlert(alertController: UIAlertController?)
}

final class ErrorAlertPresenter {
    private weak var delegate: ErrorAlertPresenterDelegate?
    
    init(delegate: ErrorAlertPresenterDelegate) {
        self.delegate = delegate
    }
}

extension ErrorAlertPresenter: ErrorAlertPresenterProtocol {
    func requestShowResultAlert(alertModel: ErrorAlertModel?) {
        let vc = UIAlertController(title: alertModel?.title, message: alertModel?.message, preferredStyle: .alert)
        let action = UIAlertAction(title: alertModel?.buttonText, style: .default, handler: alertModel?.completion)
        vc.addAction(action)
        delegate?.showErrorAlert(alertController: vc)
    }
}
