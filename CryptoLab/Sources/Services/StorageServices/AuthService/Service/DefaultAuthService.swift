import Foundation

// MARK: - DefaultAuthService
final class DefaultAuthService: AuthServiceProtocol {
    
    private let authRepository: AuthRepositoryProtocol

    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }

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
