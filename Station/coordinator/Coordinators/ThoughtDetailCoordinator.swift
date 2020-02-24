
import UIKit
import CoreData

class ThoughtDetailCoordinator: Coordinator {
    var flow: [Coordinator] = []
    var parentCoordinator: BaseCoordinator?
    var navigationController: UINavigationController
    var thought: Thought!
    var moc: NSManagedObjectContext?
    
    func start() {
        let vc = ThoughtDetailController()
        vc.coordinator = self
        vc.hidesBottomBarWhenPushed = true
        if let moc = moc, let thought = thought {
            vc.dataManager = ThoughtDetailDataManager(moc: moc, thought: thought)
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateBack() {
        
        navigationController.popViewController(animated: true)
//        navigationController.tabBarController?.tabBar.isHidden = false
    }
    
    init(withNavigationController navigationController: UINavigationController){
        self.navigationController = navigationController
//        self.navigationController.tabBarController?.tabBar.isHidden = true
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

