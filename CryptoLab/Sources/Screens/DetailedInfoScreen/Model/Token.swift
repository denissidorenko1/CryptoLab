import Foundation

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
