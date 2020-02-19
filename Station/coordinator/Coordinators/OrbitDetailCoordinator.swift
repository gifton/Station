
import UIKit

class OrbitDetailCoordinator: Coordinator {
    var flow: [Coordinator] = []
    
    var parentCoordinator: BaseCoordinator?
    
    var navigationController: UINavigationController
    
    func start() {
        let vc = UIViewController(withColor: .red)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    init(withNavigationController navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
}
