
import UIKit

extension UIViewController {
    
    convenience init(withColor color: UIColor) {
        self.init()
        view.backgroundColor = color
    }
    
    func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
