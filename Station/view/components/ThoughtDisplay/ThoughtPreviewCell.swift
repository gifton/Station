//
//  HomeEntryCell.swift
//  Rethought
//
//  Created by Dev on 6/14/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtPreviewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    // MARK: private objects
    
    private let subThoughtCount = UILabel.bodyLabel(nil, .medium)
    private var thought: ThoughtPreview?
    private let titleLabel = UILabel.bodyLabel(nil, .large)
    private let orbits = UILabel.bodyLabel(nil, .xXLarge)
    
    func set(withThought thought: ThoughtPreview) {
        self.thought = thought
        setView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension ThoughtPreviewCell {
    func setView() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = Styles.Colors.offWhite
        backgroundView?.layer.cornerRadius = 10
        backgroundView?.layer.masksToBounds = true
        
        guard let thought = thought else { return }
        
        addSubview(titleLabel)
        addSubview(orbits)
        addSubview(subThoughtCount)
        
        // title
        titleLabel.preferredMaxLayoutWidth = width.subtractPadding(.xLarge, multiplier: 2)
        titleLabel.text = thought.title
        titleLabel.sizeToFit()
        titleLabel.left = Styles.Padding.xLarge.rawValue
        titleLabel.top = Styles.Padding.xLarge.rawValue
        
        // orbits
//        orbits.text = thought.orbits
//            .icons()
//            .reduce("  ", +)
        orbits.text = "⚽️ 📚 💪🏾 🧘🏽‍♂️ 🍕"
        orbits.sizeToFit()
        orbits.preferredMaxLayoutWidth = 200.0
        orbits.left = Styles.Padding.xLarge.rawValue
        orbits.bottom = height.subtractPadding()
        orbits.textDropShadow()
        
        
        orbits.layer.cornerRadius = 4
        orbits.layer.masksToBounds = true
        
        // subthought count
        subThoughtCount.text = "19 Sub Thoughts"
        subThoughtCount.padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        subThoughtCount.sizeToFit()
        subThoughtCount.height += 10
        subThoughtCount.width += 10
        subThoughtCount.right = right.subtractPadding(.xLarge)
        subThoughtCount.bottom = height.subtractPadding()
        subThoughtCount.backgroundColor = Styles.Colors.primaryBlue
        subThoughtCount.layer.cornerRadius = 6
        subThoughtCount.layer.masksToBounds = true
        subThoughtCount.textColor = Styles.Colors.offWhite
        
        
    }
}
