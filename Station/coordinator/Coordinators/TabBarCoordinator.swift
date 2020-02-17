

import UIKit
import CoreData

// 1
// Flow Controller
// MARK: Main TabBar coordinator:
//  - incharge of creating all other coordinators on bar, and displaying
//  - tab bar does not set parent controller since it does not have a "view" of its own to pop too
final class TabBarCoordinator: Coordinator {
    
    var parentCoordinator: BaseCoordinator?
    var flow: [Coordinator] = []
    var navigationController: UINavigationController
    var tabController: UITabBarController
    var moc: NSManagedObjectContext?
    
    init(withNavigationController nav: UINavigationController) {
        
        self.navigationController = nav
        self.tabController = TabBarController()
        tabController.tabBar.tintColor = Styles.Colors.primaryBlue
        tabController.tabBar.isTranslucent = false
        tabController.tabBar.alpha = 1.0

    }
    
    func navigateBack() {
        //  go back
    }
    
    // dashboard
    // projects
    // quotes
    // calendar
    func start() {
        
        let exploreCoordinator = ExploreCoordinator(withNavigationController: navBar())
        let newCoordinator = NewThoughtCoordinator(withNavigationController: navBar())
        let quotesCoordinator = ThoughtsCoordinator(withNavigationController: navBar())
   
        exploreCoordinator.moc = moc
        newCoordinator.moc = moc
        quotesCoordinator.moc = moc
        
        let coordinators: [Coordinator] = [newCoordinator, exploreCoordinator, quotesCoordinator]
        let controllers = coordinators.controllers()
        coordinators.start()
        
        flow.append(contentsOf: coordinators)
        

        tabController.setViewControllers(controllers, animated: true)
        (tabController as? TabBarController)?.setTabIcons([.new, .explore, .thought])
        tabController.selectedIndex = 0;

        navigationController.pushViewController(tabController, animated: false)
        
    }

    
    func navBar() -> UINavigationController {
        let nav = UINavigationController()
        nav.isToolbarHidden = true
        nav.isNavigationBarHidden = true
        
        return nav
    }
}


