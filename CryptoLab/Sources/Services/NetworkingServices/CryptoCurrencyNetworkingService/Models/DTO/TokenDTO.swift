import Foundation

// MARK: - TokenDTO
struct TokenDTO: Codable {
    let id: String
    let name: String
    let symbol: String
    let marketData: MarketDataDTO
    let roiData: RoiDTO
    let supplyData: SupplyDTO

    enum CodingKeys: String, CodingKey {
        case id, name, symbol
        case marketData = "market_data"
        case roiData = "roi_data"
        case supplyData = "supply"
    }
}
