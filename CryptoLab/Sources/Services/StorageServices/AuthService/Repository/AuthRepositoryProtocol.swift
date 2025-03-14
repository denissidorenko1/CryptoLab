import Foundation

// MARK: - AuthRepositoryProtocol
protocol AuthRepositoryProtocol: Sendable {
    func saveLoginState(isLoggedIn: Bool)
    func isUserLoggedIn() -> Bool
    func clearLoginState()
}
