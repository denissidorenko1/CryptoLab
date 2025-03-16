import Foundation

// MARK: - UserDefaultsAuthRepository
final class UserDefaultsAuthRepository: AuthRepositoryProtocol {
    // MARK: - Dependencies
    private let defaults = UserDefaults.standard
    private let key = "isUserLoggedIn"

    // MARK: - Public Methods
    func saveLoginState(isLoggedIn: Bool) {
        defaults.set(isLoggedIn, forKey: key)
    }

    func isUserLoggedIn() -> Bool {
        defaults.bool(forKey: key)
    }

    func clearLoginState() {
        defaults.removeObject(forKey: key)
    }
}
