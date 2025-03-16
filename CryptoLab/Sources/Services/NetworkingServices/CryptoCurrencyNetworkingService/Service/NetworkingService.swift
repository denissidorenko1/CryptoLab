import Foundation

// MARK: - ToDoNetworkingService
final class NetworkingService {
    // MARK: - Private properties
    private let networkingService: NetworkingServiceProtocol

    // MARK: - Initializer
    init(networkingService: NetworkingServiceProtocol = DefaultNetworkingService() ) {
        self.networkingService = networkingService
    }

    // MARK: - Public methods
    func getToken(tokenName: String) async throws -> Token {
        try await networkingService.send(request: GetTokenRequest(token: tokenName), type: TokenResponseDTO.self).toToken
    }
    
    func getTokens(tokenNames: [String]) async throws -> [Token] {
        return try await withThrowingTaskGroup(of: Token.self) { taskGroup in
            var tokens: [Token] = []
            
            for tokenName in tokenNames {
                taskGroup.addTask {
                    try await self.getToken(tokenName: tokenName)
                }
            }
            
            for try await token in taskGroup {
                tokens.append(token)
            }
            
            return tokens
        }
    }
}

