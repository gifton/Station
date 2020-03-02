
import UIKit

// MARK: UIViewController helper methods
extension UIViewController {
    
    // initialize with color
    convenience init(withColor color: UIColor) {
        self.init()
        view.backgroundColor = color
    }
    
    // add new ChildViewController to current VC
    func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
