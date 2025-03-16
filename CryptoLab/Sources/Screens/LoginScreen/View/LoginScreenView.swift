import UIKit

// MARK: - LoginScreenView
final class LoginScreenView: UIViewController {
    
    // MARK: - Properties
    private let viewModel: LoginScreenViewModelProtocol
    private let coordinator: Coordinator
    
    private var loginButtonBottomConstraint: NSLayoutConstraint?
    
    // MARK: - UI Elements
    private lazy var robotView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .robot
        return imageView
    }()
    
    private lazy var loginField: InputFieldView = {
        let inputView = InputFieldView(icon: .userIcon, placeholder: "Username")
        return inputView
    }()
    
    private lazy var passwordField: InputFieldView = {
        let inputView = InputFieldView(icon: .passwordIcon, placeholder: "Password", isSecure: true)
        return inputView
    }()
    
    private lazy var loginButton: LoginButton = {
        let loginButton = LoginButton(text: "Login")
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(didTapLogin))
        loginButton.addGestureRecognizer(tapGestureRecogniser)
        return loginButton
    }()
    
    // MARK: - Initializers
    init(viewModel: LoginScreenViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitializer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBackground
        setupKeyboardObservers()
        addSubviews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        view.addSubview(robotView)
        view.addSubview(loginField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        robotView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: robotView.centerXAnchor),
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: robotView.topAnchor, constant: 0),
        ])
        
        loginField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            loginField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            loginField.heightAnchor.constraint(equalToConstant: 55)
            
        ])
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 15),
            passwordField.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 15),
            loginButton.heightAnchor.constraint(equalToConstant: 55),
        ])
        
        loginButtonBottomConstraint = loginButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -133)
        loginButtonBottomConstraint?.isActive = true
    }
    
    private func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Actions
    @objc func didTapLogin() {
        do {
            try viewModel.validateCredentials(
                login: loginField.textField.text ?? "",
                password: passwordField.textField.text ?? ""
            )
            
            guard let coordinator = coordinator as? LoginScreenCoordinator else { return }
            coordinator.goToMainScreen()
            
        } catch {
            presentAlert(title: "Ошибка авторизации", message: error.localizedDescription)
        }
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        let adjustedSpacing = max(-30, -keyboardHeight + 50)

        loginButtonBottomConstraint?.constant = adjustedSpacing
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        loginButtonBottomConstraint?.constant = -133
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

