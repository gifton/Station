
import UIKit

// MARK: CGFLoat padding helper methods
extension CGFloat {
    
    // add standard defined padding to given float
    func addPadding(_ padding: Styles.Padding = .large, multiplier: CGFloat = 1) -> CGFloat {
        return self + (padding.rawValue * multiplier)
    }
    
    // subtract standard defined padding to given float
    func subtractPadding(_ padding: Styles.Padding = .large, multiplier: CGFloat = 1) -> CGFloat {
        return self - (padding.rawValue * multiplier)
    }
}
