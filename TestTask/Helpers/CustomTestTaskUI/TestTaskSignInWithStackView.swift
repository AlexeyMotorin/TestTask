import UIKit

enum SignInWith: String {
    case apple = "Apple"
    case google = "Google"
}

protocol TestTaskSignInWithStackViewDelegate: AnyObject {
    func signInWithAccount(account: SignInWith?)
}

final class TestTaskSignInWithStackView: UIStackView {
    weak var delegate: TestTaskSignInWithStackViewDelegate?
    var account: SignInWith?
        
    private lazy var signInWithButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.ttBlack, for: .normal)
        button.addTarget(self, action: #selector(signInWithButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 10)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(frame: CGRect, account: SignInWith) {
        super.init(frame: frame)
        self.account = account
        translatesAutoresizingMaskIntoConstraints = false
        configStackView(account.rawValue)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configStackView(_ value: String) {
        addArrangedSubview(imageView)
        addArrangedSubview(signInWithButton)
        
        distribution = .fillProportionally
        
        let buttonTitle = "Sign in with \(value)"
        
        signInWithButton.setTitle(buttonTitle, for: .normal)
        imageView.image = UIImage(named: value)
    }
    
    @objc private func signInWithButtonTapped() {
        delegate?.signInWithAccount(account: account)
    }
}
