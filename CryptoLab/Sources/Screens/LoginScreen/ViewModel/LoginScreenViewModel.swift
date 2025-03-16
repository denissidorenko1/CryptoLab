//import Foundation
//
//protocol LoginScreenViewModelProtocol {
//    
//}
//
//final class LoginScreenViewModel: LoginScreenViewModelProtocol {
//
//    
//    let authService: AuthServiceProtocol
//    
//    init(authService: AuthServiceProtocol = DefaultAuthService(authRepository: UserDefaultsAuthRepository())) {
//        self.authService = authService
//    }
//    
//    func validateCredentials(login: String, password: String) throws {
//        try authService.login(username: login, password: password)
//    }
//
//}

import Foundation

protocol LoginScreenViewModelProtocol {
    func validateCredentials(login: String, password: String) throws
}

final class LoginScreenViewModel: LoginScreenViewModelProtocol {
    
    // MARK: - Dependencies
    private let authService: AuthServiceProtocol
    
    // MARK: - Init
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    // MARK: - Methods
    func validateCredentials(login: String, password: String) throws {
        try authService.login(username: login, password: password)
    }
}
