
import UIKit

// MARK: UIViewController helper methods
extension UIViewController {
    
    // initialize with color
    convenience init(withColor color: UIColor) {
        self.init()
        view.backgroundColor = color
    }
    
}
