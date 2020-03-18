
import UIKit
import CoreData

// coordinator handles movement from explore page to child views
final class OrbitDetailCoordinator: Coordinator {
    var flow: [Coordinator] = []
    
    var parentCoordinator: BaseCoordinator?
    var navigationController: UINavigationController
    private var dataManager: DataManager?
    var orbit: Orbit!
    var moc: NSManagedObjectContext?
    
    func start() {
        let vc = OrbitDetailController()
        vc.coordinator = self
        if let moc = moc, let orbit = orbit { dataManager = OrbitDetailDataManager(moc: moc, orbit: orbit) }
        vc.dataManager = dataManager
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    init(withNavigationController navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
}
