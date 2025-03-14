import Foundation

// MARK: - SupplyDTO
struct SupplyDTO: Codable {
    let revivedSupply90d: Double?

    enum CodingKeys: String, CodingKey {
        case revivedSupply90d = "supply_revived_90d"
    }
}
