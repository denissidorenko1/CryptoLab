import Foundation

extension Double {
    func asUSDCurrencyString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return "$"+(formatter.string(from: NSNumber(value: self)) ?? "0.00")
    }
    
    func asAbsolutePercentageString() -> String {
        return String(format: "%.1f%%", abs(self))
    }
    
}
