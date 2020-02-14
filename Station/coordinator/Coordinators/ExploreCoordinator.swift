//
//  NewThoughtCoordinator.swift
//  Mylib
//
//  Created by Gifton on 2/13/20.
//  Copyright © 2020 Gifton. All rights reserved.
//

import UIKit

class ExploreCoordinator: Coordinator {
    
    var flow: [Coordinator] = []
    
    var parentCoordinator: BaseCoordinator? = nil
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        let vc = UIViewController(withColor: Styles.Colors.primaryRed)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
    func navigateBack() {
        //
    }
    
    required init(withNavigationController nav: UINavigationController) {
        navigationController = nav
    }
    
}
