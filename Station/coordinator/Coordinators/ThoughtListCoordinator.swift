//
//  NewThoughtCoordinator.swift
//  Mylib
//
//  Created by Gifton on 2/13/20.
//  Copyright © 2020 Gifton. All rights reserved.
//

import UIKit
import CoreData

// coordinator handles movement from explore page to child views
class ThoughtListCoordinator: Coordinator {
    
    var flow: [Coordinator] = []
    var moc: NSManagedObjectContext?
    var parentCoordinator: BaseCoordinator? = nil
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        
        let vc = ThoughtListController()
        
        if let moc = moc {
            let dm = ThoughtListDataManager(moc: moc)
            vc.dataManager = dm
        }
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    required init(withNavigationController nav: UINavigationController) {
        self.navigationController = nav
    }
}

extension ThoughtListCoordinator: ThoughtDetailFlow {
    func showThought(_ thought: Thought) {
        let coordinator = ThoughtDetailCoordinator(withNavigationController: navigationController)
        coordinator.thought = thought
        coordinator.moc = moc
        flow.append(coordinator)
        coordinator.start()
    }
}


extension ThoughtListCoordinator {
    func showInfoController() {
        let infoController = InfoController(type: .thought)
        infoController.coordinator = self
        navigationController.showDetailViewController(infoController, sender: self)
        
    }
}
