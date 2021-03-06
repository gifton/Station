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
final class NewThoughtCoordinator: Coordinator {
    
    var flow: [Coordinator] = []
    var moc: NSManagedObjectContext? 
    var parentCoordinator: BaseCoordinator? = nil
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        let vc = NewThoughtController()
        vc.coordinator = self
        
        if let moc = moc {
            let dm = NewThoughtDataManager(moc: moc)
            vc.dataManager = dm
        }
        
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    required init(withNavigationController nav: UINavigationController) {
        self.navigationController = nav

    }
    
    
    func navigateBack() {
        //
    }
    
    
}
