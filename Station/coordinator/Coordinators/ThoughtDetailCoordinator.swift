
import UIKit
import CoreData

// coordinator handles movement from explore page to child views
class ThoughtDetailCoordinator: Coordinator {
    var flow: [Coordinator] = []
    var parentCoordinator: BaseCoordinator?
    var navigationController: UINavigationController
    var thought: Thought!
    var moc: NSManagedObjectContext?
    private  var dataManager: DataManager?
    private var vc: Controller!
    func start() {
        
        
        if let moc = moc, let thought = thought {
            
            dataManager = ThoughtDetailDataManager(moc: moc, thought: thought)
            vc = ThoughtDetailController(dm: dataManager as! ThoughtDetailDataManager, coordinator: self)
            vc.hidesBottomBarWhenPushed = true
        } else { vc = Controller() }
        
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
    func createSubThought(ofType type: SubThoughtType, completion: () -> ()) {
        let controller = NewSubThoughtController(controllerForType: type, title: (dataManager as? ThoughtDetailDataManager)?.thought.title ?? "Not available")
        navigationController.showDetailViewController(controller, sender: nil)
        controller.delegate = self
    }
}

extension ThoughtDetailCoordinator: NewSubThoughtDelegate {
    func createPreview(_ preview: SubThoughtPreview) {
        (dataManager as? ThoughtDetailDataManager)?.createSubThought(withPreview: preview)
        navigationController.dismiss(animated: true, completion: nil)
    }
}
