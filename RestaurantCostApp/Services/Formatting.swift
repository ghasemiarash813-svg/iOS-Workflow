import Foundation

enum CurrencyFormatter {
    static func rial(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 0
        let formatted = formatter.string(from: NSNumber(value: value)) ?? "0"
        return "\(formatted) ریال"
    }

    static func toman(_ value: Double) -> String {
        let tomanValue = value / 10
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 0
        let formatted = formatter.string(from: NSNumber(value: tomanValue)) ?? "0"
        return "\(formatted) تومان"
    }
}
