
import UIKit
import CoreData

class ThoughtDetailCoordinator: Coordinator {
    var flow: [Coordinator] = []
    var parentCoordinator: BaseCoordinator?
    var navigationController: UINavigationController
    var thought: Thought!
    var moc: NSManagedObjectContext?
    private  var dataManager: DataManager?
    
    func start() {
        let vc = ThoughtDetailController()
        vc.coordinator = self
        vc.hidesBottomBarWhenPushed = true
        if let moc = moc, let thought = thought {
            dataManager = ThoughtDetailDataManager(moc: moc, thought: thought)
            vc.dataManager = dataManager
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
    func createSubThought(ofType type: SubThoughtType, completion: () -> ()) {
        let controller = NewSubThoughtController(controllerForType: type, title: (dataManager as? ThoughtDetailDataManager)?.thought.title ?? "Not available")
        navigationController.showDetailViewController(controller, sender: nil)
    }
    
    func saveSubThought(_ sb: SubThoughtPreview) {
        (dataManager as? ThoughtDetailDataManager)?.createSubThought(withPreview: sb)
    }
    
}

