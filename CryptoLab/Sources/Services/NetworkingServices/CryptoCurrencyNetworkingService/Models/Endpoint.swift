import Foundation

// MARK: Endpoint
enum Endpoint {
    // MARK: - Cases
    case token(name: String)
    
    // MARK: - Public Properties
    static let baseURL: URL = URL(string: "https://data.messari.io/api/v1")!
    
    // MARK: - Computed Properties
    var path: String {
        switch self {
        case let .token(name): return "assets/\(name)/metrics"
        }
    }
    
    var url: URL? {
        let components = URLComponents(url: Endpoint.baseURL.appending(path: self.path), resolvingAgainstBaseURL: false)
        switch self {
        case .token(_):
            return components?.url
        }
    }
}
