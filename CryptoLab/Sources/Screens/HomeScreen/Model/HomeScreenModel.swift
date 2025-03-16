import Foundation

// MARK: - SortingOrder
enum SortingOrder {
    case ascending
    case descending

    mutating func toggle() {
        self = self == .ascending ? .descending : .ascending
    }
}

// MARK: - HomeScreenModel
struct HomeScreenModel {
    var tokens: [Token]
    var sortOrder: SortingOrder
    
    mutating func toggleSorting() {
        sortOrder.toggle()
        tokens.sort { sortOrder == .ascending ? $0.dayChangePercent < $1.dayChangePercent : $0.dayChangePercent >= $1.dayChangePercent }
    }
}
