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
        
//        let display = UIScrollView(frame: view.frame)
//        display.contentSize = .init(Device.width, Device.height * 2)
//        display.backgroundColor = .lightGray
//        display.showsVerticalScrollIndicator = true
//        display.isPagingEnabled = true
//        display.delegate = self
//
//        view.addSubview(display)
        
        let head = DashboardHead(point: .zero)
        view.addSubview(head)
        
    }
    
    var orbits: [OrbitPreview] = [
        OrbitPreview(title: "Personal", icon: "🔒"),
        OrbitPreview(title: "Soccer", icon: "⚽️"),
        OrbitPreview(title: "Traveling", icon: "🛤"),
        OrbitPreview(title: "Meditation", icon: "🧘🏽‍♂️"),
        OrbitPreview(title: "Programming", icon: "👨🏽‍💻"),
        OrbitPreview(title: "Station", icon: "☁️"),
        OrbitPreview(title: "Gift idea", icon: "🎄")
    ]
    
    var thoughts: [ThoughtPreview] = []
    private let haptic = UINotificationFeedbackGenerator()
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) { haptic.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success) }
}

