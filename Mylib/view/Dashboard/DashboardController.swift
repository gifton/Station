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
        
        let tv = UITableView(frame: CGRect(x: Styles.Padding.large.rawValue, y: 100, width: Device.width - (Styles.Padding.large.rawValue * 2), height: Device.height - 100))
        tv.delegate = self
        tv.dataSource = self
        tv.register(cellWithClass: ThoughtPreviewCell.self)
        tv.separatorStyle = .none
        tv.backgroundView = .init(withColor: .clear)
        tv.backgroundColor = .clear
        
        view.addSubview(tv)
        
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
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orbits.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ThoughtPreviewCell.self, for: indexPath)
        cell.set(withThought: ThoughtPreview(title: "Giftons Handy Thought", location: nil))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

