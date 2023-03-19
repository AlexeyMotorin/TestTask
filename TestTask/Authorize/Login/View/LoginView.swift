import UIKit

protocol LoginViewProtocol: AnyObject {
    var presenter: LoginViewPresenterProtocol? { get set }
    func setSecureTextEntry(_ bool: Bool)
    func requestShowErrorAlert(alertModel: ErrorAlertModel)
}

final class LoginView: UIView {
    
    // MARK: - Public properties
    weak var viewController: LoginViewControllerProtocol?
    var presenter: LoginViewPresenterProtocol?
    
    // MARK: - Private properties
    private struct Constants {
        static let welcomeLabelText = "Welcome back"
        static let textFieldCornenRadius: CGFloat = 16
        static let firstNamePlaceholder = "First name"
        static let passwordPlaceholder = "Password"
        static let iconImageNamed = "IconClick"
        static let loginButtonText = "Login"
    }
    
    // MARK: UI
    private lazy var welcomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Medium", size: 30)
        label.text = Constants.welcomeLabelText
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
    
    private lazy var passwordTextField: TestTaskTextField = {
        let textField = TestTaskTextField(frame: .zero, placeHolderText: Constants.passwordPlaceholder)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .ttPurple
        button.layer.cornerRadius = 18
        button.setTitleColor(.ttLightGray, for: .normal)
        button.setTitle(Constants.loginButtonText, for: .normal)
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Montserrat-bold", size: 14)
        return button
    }()
    
    private lazy var iconPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: Constants.iconImageNamed)
        button.setImage(image, for: .normal)
        button.tintColor = .ttGray
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        return button
    }()
    
    // MARK: - init
    init(frame: CGRect, viewController: LoginViewControllerProtocol?) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.viewController = viewController
        setupView()
        presenter = LoginViewPresenter()
        presenter?.view = self
        presenter?.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupView() {
        backgroundColor = .systemBackground
        addSubviews()
        activateConstraints()
        firstNameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func addSubviews() {
        self.addSubviews(welcomLabel,textFieldsStackView, loginButton, iconPasswordButton)
        
        textFieldsStackView.addArrangedSubview(firstNameTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
    }
    
    private func activateConstraints() {
        let textFieldHeight = frame.height / 25
        let stackWidth = frame.width / 1.2
        
        NSLayoutConstraint.activate([
            welcomLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            welcomLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: frame.height / 5.5),
            textFieldsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldsStackView.topAnchor.constraint(equalTo: welcomLabel.bottomAnchor, constant: frame.height / 10),
            
            firstNameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            firstNameTextField.widthAnchor.constraint(equalToConstant: stackWidth),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            passwordTextField.widthAnchor.constraint(equalToConstant: stackWidth),
            
            loginButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: frame.height / 10),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 55),
            loginButton.widthAnchor.constraint(equalToConstant: stackWidth),
            
            iconPasswordButton.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: -15),
            iconPasswordButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
        ])
    }
    
    @objc private func signInButtonTapped() {
        
       
        let firstName = firstNameTextField.text
        let password = passwordTextField.text
        
        presenter?.checkAccount(with: firstName, and: password)
  
    }
    
    @objc private func showPassword() {
        presenter?.showPassword()
    }
    
    private func resetTextField(_ textField: UITextField) {
        textField.shake()
        textField.text = ""
    }
}


// MARK: LoginViewProtocol
extension LoginView: LoginViewProtocol {
    func requestShowErrorAlert(alertModel: ErrorAlertModel) {
        resetTextField(passwordTextField)
        resetTextField(firstNameTextField)
        viewController?.showErrorAlert(alertModel: alertModel)
    }
    
    func setSecureTextEntry(_ bool: Bool) {
        passwordTextField.isSecureTextEntry = bool
    }
}

// MARK: UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}

