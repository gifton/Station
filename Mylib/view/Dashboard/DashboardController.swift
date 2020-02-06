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
        
        let test = OrbitSelector(point: CGPoint(0, 100), title: "Add Orbits", delegate: self)
        view.addSubview(test)
    }
    
    
}


extension DashboardController: OrbitSelectorDelegate {
    func createNewOrbit() {
        print("blah blaj")
    }
    
    var orbits: [OrbitPreview] {
        return [
            OrbitPreview(title: "Personal", icon: "🔒"),
            OrbitPreview(title: "writing", icon: "🖋"),
            OrbitPreview(title: "sports", icon: "⚽️"),
            OrbitPreview(title: "meditation", icon: "🧘🏽‍♂️"),
            OrbitPreview(title: "Things to stop doing", icon: "🚦"),
            OrbitPreview(title: "Traveling", icon: "🛤"),
        ]
    }
    
    func didSelectOrbit(atIndex index: Int) {
        print("selected index")
    }
}
