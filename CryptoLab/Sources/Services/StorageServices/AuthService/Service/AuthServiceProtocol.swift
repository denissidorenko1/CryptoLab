import Foundation

// MARK: - AuthServiceProtocol
protocol AuthServiceProtocol: Sendable {
    func login(username: String, password: String) throws
    func logout()
    func isAuthenticated() -> Bool
}
