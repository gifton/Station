
import UIKit

extension CGFloat {
    func addPadding(_ padding: Styles.Padding = .large, multiplier: CGFloat = 1) -> CGFloat {
        return self + (padding.rawValue * multiplier)
    }
    
    func subtractPadding(_ padding: Styles.Padding = .large, multiplier: CGFloat = 1) -> CGFloat {
        return self - (padding.rawValue * multiplier)
    }
}
