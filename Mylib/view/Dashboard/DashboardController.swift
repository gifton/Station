//
//  DashboardController.swift
//  Mylib
//
//  Created by Gifton on 1/30/20.
//  Copyright © 2020 Gifton. All rights reserved.
//

import UIKit


class DashboardController: Controller {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let test = UILabel.directionLabel("Explore", direction: .top)
        
        view.addSubview(test)
    }
    
    
}
