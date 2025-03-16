import Foundation

// MARK: - LoginScreenViewModelProtocol
protocol LoginScreenViewModelProtocol {
    func validateCredentials(login: String, password: String) throws
}

// MARK: - LoginScreenViewModel
final class LoginScreenViewModel: LoginScreenViewModelProtocol {
    // MARK: - Dependencies
    private let authService: AuthServiceProtocol
    private let model: LoginScreenModelProtocol
    
    // MARK: - Init
    init(authService: AuthServiceProtocol, model: LoginScreenModelProtocol) {
        self.authService = authService
        self.model = model
    }
    
    // MARK: - Methods
    func validateCredentials(login: String, password: String) throws {
        try authService.login(username: login, password: password)
    }
}
