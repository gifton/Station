
import UIKit

extension UIViewController {
    convenience init(withColor color: UIColor) {
        self.init()
        view.backgroundColor = color
    }
}
