import Foundation

// MARK: - ToDoNetworkingService
final class NetworkingService {

    // FIXME: - избавиться от синглтона!
    // MARK: - Dependencies
    static let shared = NetworkingService()

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

// FIXME: - переместить в нормальное место
struct Token {
    let id: String
    let name: String
    let symbol: String
    let usdPrice: Double
    let marketVolume: Double
    let supply: Double?
    let dayChangePercent: Double
    let weekChangePercent: Double?
    let yearChangePercent: Double?
}

