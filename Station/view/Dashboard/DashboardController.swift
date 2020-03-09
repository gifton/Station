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
        view.backgroundColor = Styles.Colors.offWhite
        
        let head = DashboardHead(point: .zero)
        view.addSubview(head)
        
        
    }
    
    var thoughts: [ThoughtPreview] = []
    
}

