import Foundation

// MARK: - AuthError
enum AuthError: Error, LocalizedError {
    case invalidCredentials

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Неверный логин или пароль"
        }
    }
}
