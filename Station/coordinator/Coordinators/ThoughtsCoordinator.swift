//
//  NewThoughtCoordinator.swift
//  Mylib
//
//  Created by Gifton on 2/13/20.
//  Copyright © 2020 Gifton. All rights reserved.
//

import UIKit
import CoreData
class ThoughtsCoordinator: Coordinator {
    
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

extension ThoughtsCoordinator: ThoughtDetailFlow {
    func showThought(_ thought: Thought) {
        
    }
    
    func showTHought(_ id: String) {
//
    }
}


extension ThoughtsCoordinator {
    func showInfoController() {
        let infoController = InfoController(type: .thought)
        infoController.coordinator = self
        navigationController.showDetailViewController(infoController, sender: self)
        
    }
    
    func showSortOptions(completion: (SortOption) -> ()) {
        
    }
}
