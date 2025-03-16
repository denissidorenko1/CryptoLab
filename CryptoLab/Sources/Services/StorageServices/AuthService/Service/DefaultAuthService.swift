import Foundation

// MARK: - DefaultAuthService
final class DefaultAuthService: AuthServiceProtocol {
    // MARK: - Dependencies
    private let authRepository: AuthRepositoryProtocol

    // MARK: - Initializer
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
    
    // MARK: - Public Methods
    func login(username: String, password: String) throws {
        guard username == "1234" && password == "1234" else {
            throw AuthError.invalidCredentials
        }
        
        authRepository.saveLoginState(isLoggedIn: true)
    }

    func logout() {
        authRepository.clearLoginState()
    }

    func isAuthenticated() -> Bool {
        authRepository.isUserLoggedIn()
    }
}
