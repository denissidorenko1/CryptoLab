import Foundation

// MARK: - MarketDataDTO
struct MarketDataDTO: Codable {
    let priceUSD: Double
    let priceChange24hPercent: Double
    let volume24h: Double

    enum CodingKeys: String, CodingKey {
        case priceUSD = "price_usd"
        case priceChange24hPercent = "percent_change_usd_last_24_hours"
        case volume24h = "volume_last_24_hours"
    }
}
