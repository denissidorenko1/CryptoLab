import Foundation

// MARK: - TokenResponseDTO
struct TokenResponseDTO: Codable {
    let token: TokenDTO
    
    enum CodingKeys: String, CodingKey {
        case token = "data"
    }
}

extension TokenResponseDTO {
    var toToken: Token {
        return Token(
            id: self.token.id,
            name: self.token.name,
            symbol: self.token.symbol,
            usdPrice: self.token.marketData.priceUSD,
            marketVolume: self.token.marketData.volume24h,
            supply: self.token.supplyData.revivedSupply90d,
            dayChangePercent: self.token.marketData.priceChange24hPercent,
            weekChangePercent: self.token.roiData.weeklyChangePercent,
            yearChangePercent: self.token.roiData.yearlyChangePercent
        )
    }
}
