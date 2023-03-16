import UIKit

protocol SignInPageViewProtocol: AnyObject {
    var presenter: SignInPagePresenterProtocol? { get set}
    func errorEmailEnter()
}

final class SignInPageView: UIView {
    
    weak var viewController: SignInPageViewControllerProtocol?
    var presenter: SignInPagePresenterProtocol?
    
    private struct Constants {
        static let textFieldCornenRadius: CGFloat = 16
        static let firstNamePlaceholder = "First name"
        static let lastNamePlaceholder = "Last name"
        static let emailPlaceholder = "Email"
        static let signInButtonText = "Sign in"
        static let logInButtonText = "Log in"
    }
    
    init(frame: CGRect, viewController: SignInPageViewControllerProtocol?) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.viewController = viewController
        setupView()
        presenter = SignInPagePresenter()
        presenter?.view = self
        presenter?.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UI
    private lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat", size: 30)
        label.text = "Sign in"
        return label
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    
    private lazy var firstNameTextField: TestTaskTextField = {
        let textField = TestTaskTextField(frame: .zero, placeHolderText: Constants.firstNamePlaceholder)
        return textField
    }()
    
    private lazy var lastNameTextField: TestTaskTextField = {
        let textField = TestTaskTextField(frame: .zero, placeHolderText: Constants.lastNamePlaceholder)
        return textField
    }()
    
    private lazy var emailTextField: TestTaskTextField = {
        let textField = TestTaskTextField(frame: .zero, placeHolderText: Constants.emailPlaceholder)
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .ttPurple
        button.layer.cornerRadius = 18
        button.setTitleColor(.ttLightGray, for: .normal)
        button.setTitle(Constants.signInButtonText, for: .normal)
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Montserrat", size: 16)
        return button
    }()
    
    private lazy var questionAboutAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .ttGray
        label.font = UIFont(name: "Montserrat", size: 10)
        label.text = "Already have an account?"
        return label
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.ttBlue, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitle(Constants.logInButtonText, for: .normal)
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Montserrat", size: 10)
        return button
    }()
    
    private lazy var signInWithStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    
    private lazy var googleSignInWithStackView: TestTaskSignInWithStackView = {
        let stackView = TestTaskSignInWithStackView(frame: .zero, account: .google)
        return stackView
    }()
    private lazy var appleSignInWithStackView: TestTaskSignInWithStackView = {
        let stackView = TestTaskSignInWithStackView(frame: .zero, account: .apple)
        return stackView
    }()
    
    private func setupView() {
        backgroundColor = .ttBackgroundColor
        googleSignInWithStackView.delegate = self
        appleSignInWithStackView.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        self.addSubviews()
        activateConstraints()
    }
    
    private func addSubviews() {
        addSubviews(signInLabel, textFieldsStackView, questionAboutAccountLabel, logInButton, signInWithStackView)
        textFieldsStackView.addArrangedSubview(firstNameTextField)
        textFieldsStackView.addArrangedSubview(lastNameTextField)
        textFieldsStackView.addArrangedSubview(emailTextField)
        textFieldsStackView.addArrangedSubview(signInButton)
        
        signInWithStackView.addArrangedSubview(googleSignInWithStackView)
        signInWithStackView.addArrangedSubview(appleSignInWithStackView)
        
    }
    
    private func activateConstraints() {
        let textFieldHeight = frame.height / 25
        let stackWidth = frame.width / 1.2
        
        NSLayoutConstraint.activate([
            signInLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signInLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: frame.height / 5.5),
            
            textFieldsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldsStackView.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: frame.height / 10),
            
            firstNameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            firstNameTextField.widthAnchor.constraint(equalToConstant: stackWidth),
            
            lastNameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            lastNameTextField.widthAnchor.constraint(equalToConstant: stackWidth),
            
            emailTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            emailTextField.widthAnchor.constraint(equalToConstant: stackWidth),
            
            signInButton.heightAnchor.constraint(equalToConstant: 55),
            signInButton.widthAnchor.constraint(equalToConstant: stackWidth),
            
            questionAboutAccountLabel.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: frame.height / 40),
            questionAboutAccountLabel.leadingAnchor.constraint(equalTo: textFieldsStackView.leadingAnchor),
            
            logInButton.leftAnchor.constraint(equalTo: questionAboutAccountLabel.rightAnchor, constant: 10),
            logInButton.centerYAnchor.constraint(equalTo: questionAboutAccountLabel.centerYAnchor),
            
            signInWithStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signInWithStackView.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: frame.height / 20),
            signInWithStackView.widthAnchor.constraint(equalToConstant: frame.width / 2)
            
        ])
    }
    
    @objc private func signInButtonTapped() {
        guard firstNameTextField.text != "" else {
            firstNameTextField.shake()
            return
        }
        
        guard lastNameTextField.text != "" else {
            lastNameTextField.shake()
            return
        }
        
        guard
            emailTextField.text != "",
            let email = emailTextField.text,
            let presenter = presenter,
            presenter.checkValidEmail(with: email)
        else {
            emailTextField.shake()
            return
        }
        viewController?.signIn()
    }
    
    @objc private func logInButtonTapped() {
        viewController?.logIn()
    }
}

extension SignInPageView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            let email = textField.text
            _ = presenter?.checkValidEmail(with: email)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}

extension SignInPageView: SignInPageViewProtocol {
    func errorEmailEnter() {
        emailTextField.shake()
        emailTextField.text = ""
    }
}

extension SignInPageView: TestTaskSignInWithStackViewDelegate {
    func signInWithAccount(account: SignInWith?) {
        viewController?.signInWith(account: account)
    }
}
