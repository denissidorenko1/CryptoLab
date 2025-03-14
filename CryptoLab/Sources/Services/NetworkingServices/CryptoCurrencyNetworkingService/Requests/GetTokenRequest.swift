import Foundation

// MARK: - GetToDoItemListRequest
struct GetTokenRequest: NetworkRequest {
    let token: String
    var endPoint: URL? { Endpoint.token(name: token).url }
    let httpMethod: HTTPMethod = .get
}
