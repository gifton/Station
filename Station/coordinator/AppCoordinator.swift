
import UIKit
import CoreData

// App coordinator handles authentication, and window creation

final class AppCoordinator: Coordinator {
    
    var parentCoordinator: BaseCoordinator?
    var flow: [Coordinator] = []
    var navigationController: UINavigationController
    var window: UIWindow
    var moc: NSManagedObjectContext?
    
    func start() {
        
        var coordinator = verifyLogin()
        coordinator.parentCoordinator = self
        // no parent coordinator is set because new coordinator  will  be set as default parent
        coordinator.start()
        flow.append(coordinator)
        window.rootViewController = coordinator.navigationController
        window.makeKeyAndVisible()
        
    }
    
    func navigateBack() {
        
        navigationController.popViewController(animated: true)
        flow.removeLast()
        
    }
    
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
    }
    
    private func verifyLogin() -> Coordinator {
        
        // TODO: logic for login verification
        //check UserDefaults storage to see if user is authenticated
        // - if authenticated, return homeCoordinator
        // - if NOT authenticated, return loginCoordinator
        //otherwise set defaults to 1
        
        let coo = TabBarCoordinator(withNavigationController: navigationController)
        coo.moc = moc
        return coo
        
    }
}

extension AppCoordinator: BaseCoordinator {
    func finishFlow() {
        navigationController.popToRootViewController(animated: true)
    }
}



