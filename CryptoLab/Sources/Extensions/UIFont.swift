import UIKit

extension UIFont {
    private enum FontName: String, CaseIterable {
        case poppinsRegular =  "Poppins-Regular"
        case poppinsMedium =  "Poppins-Medium"
        case poppinsSemiBold = "Poppins-SemiBold"
    }
    
    static func poppinsRegular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: FontName.poppinsRegular.rawValue, size: size) else {
            assertionFailure("Failed to load font: \(FontName.poppinsRegular.rawValue)")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    static func poppinsMedium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: FontName.poppinsMedium.rawValue, size: size) else {
            assertionFailure("Failed to load font: \(FontName.poppinsMedium.rawValue)")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    static func poppinsSemiBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: FontName.poppinsSemiBold.rawValue, size: size) else {
            assertionFailure("Failed to load font: \(FontName.poppinsSemiBold.rawValue)")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
