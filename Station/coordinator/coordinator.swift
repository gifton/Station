
import UIKit

// coordinator patter handles all flows between screens
// flows are strings  of views
// flows  can move forward or backward 1 view  at a time,
// adding and removing the most recent view from its stack
// unless  flowCompletor  delegate is conformed, then a root coordinator can defined
// coordinator should instantiate/handle:
//      - view controller
//      - DataManager
//      - transition coordinator

protocol Coordinator {
    
    var flow: [Coordinator] { get set }
    var parentCoordinator: BaseCoordinator? { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func navigateBack()
    
    init(withNavigationController nav: UINavigationController)
    
}

// MARK: BaseCoordinator
// basecoordinator applied to all root / home coordinators
protocol BaseCoordinator: Coordinator {
    
    // confirm flow completion and remove flows from stack
    func finishFlow()
}

extension Coordinator {
    var controller: UIViewController {
        return navigationController
    }
}

// get navigationcontrollers from list of coordinators
extension Array where Element == Coordinator {
    func controllers() -> [UIViewController] {
        var controllers = [UIViewController]()
        self.forEach { controllers.append($0.controller) }
        
        return controllers
    }
    func start() {
        forEach {
            $0.start()
        }
    }
}
