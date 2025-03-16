import Foundation

// MARK: - SortingOrder
enum SortingOrder {
    case ascending
    case descending

    mutating func toggle() {
        self = self == .ascending ? .descending : .ascending
    }
}

// MARK: - HomeScreenModelProtocol
protocol HomeScreenModelProtocol {
    var tokens: [Token] { get set }
    var sortOrder: SortingOrder { get set }
    
    mutating func toggleSorting()
}

// MARK: - HomeScreenModel
struct HomeScreenModel: HomeScreenModelProtocol {
    var tokens: [Token]
    var sortOrder: SortingOrder
    
    mutating func toggleSorting() {
        sortOrder.toggle()
        tokens.sort { sortOrder == .ascending ? $0.dayChangePercent < $1.dayChangePercent : $0.dayChangePercent >= $1.dayChangePercent }
    }
}
