//
//  NewThoughtCoordinator.swift
//  Mylib
//
//  Created by Gifton on 2/13/20.
//  Copyright © 2020 Gifton. All rights reserved.
//

import UIKit

class NewThoughtCoordinator: Coordinator {
    
    var flow: [Coordinator] = []
    
    var parentCoordinator: BaseCoordinator? = nil
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        let vc = UIViewController(withColor: Styles.Colors.primaryBlue)
        navigationController.pushViewController(vc, animated: true)
    }
    
    required init(withNavigationController nav: UINavigationController) {
        self.navigationController = nav

    }
    
    
    func navigateBack() {
        //
    }
    
    
}
