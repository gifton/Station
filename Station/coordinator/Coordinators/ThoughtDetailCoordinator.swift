
import UIKit

class ThoughtDetailCoordinator: Coordinator {
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

extension ThoughtDetailCoordinator: OrbitDetailFlow {
    func showOrbit(_ orbit: Orbit) {
        print("showing orbit")
    }
    
    
}

extension ThoughtDetailCoordinator: NewSubThoughtFlow {
    func createSubThought(for thought: Thought, ofType type: SubThoughtType, completion: () -> ()) {
        print("creating subthought")
    }
    
    
}
