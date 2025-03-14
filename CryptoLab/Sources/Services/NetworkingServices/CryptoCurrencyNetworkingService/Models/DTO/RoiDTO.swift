import Foundation

// MARK: - RoiDTO
struct RoiDTO: Codable {
    let weeklyChangePercent: Double?
    let yearlyChangePercent: Double?

    enum CodingKeys: String, CodingKey {
        case weeklyChangePercent = "percent_change_last_1_week"
        case yearlyChangePercent = "percent_change_last_1_year"
    }
}
