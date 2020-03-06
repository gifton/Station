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
class ExploreCoordinator: Coordinator {
    
    var flow: [Coordinator] = []
    var moc: NSManagedObjectContext?
    var parentCoordinator: BaseCoordinator? = nil
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        let vc = ExploreController()
        vc.coordinator = self
        if let moc = moc {
            let dm = ExploreDataManager(moc: moc)
            dm.start(completion: nil)
            vc.dataManager = dm
        }
        
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    
    
    func navigateBack() {
        //
    }
    
    required init(withNavigationController nav: UINavigationController) {
        navigationController = nav
    }
    
}
