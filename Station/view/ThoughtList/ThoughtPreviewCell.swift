//
//  HomeEntryCell.swift
//  Rethought
//
//  Created by Dev on 6/14/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

final class ThoughtPreviewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    // MARK: private objects
    
    private let subThoughtCount = UILabel.body(nil, .medium)
    private var thought: ThoughtPreview?
    private let titleLabel = UILabel.body(nil, .large)
    private let orbits = UILabel.body(nil, .xXLarge)
    
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
        backgroundColor = Colors.softBG.withAlphaComponent(0.4)
        layer.borderWidth = 2
        layer.borderColor = Colors.lightGray.cgColor
        guard let thought = thought else { return }
        
        addSubview(titleLabel)
        addSubview(orbits)
        addSubview(subThoughtCount)
        
        // title
        titleLabel.preferredMaxLayoutWidth = width.subtractPadding(.xLarge, multiplier: 2)
        titleLabel.text = thought.title
        titleLabel.frame = CGRect(origin: .init(Styles.Padding.xLarge.rawValue), size: .init(width.subtractPadding(.xLarge, multiplier: 2), 20))
        
        // orbits
        orbits.text = thought.orbits.icons().joined(separator: " ")
        orbits.sizeToFit()
        orbits.preferredMaxLayoutWidth = 200.0
        orbits.right = right.subtractPadding(.xLarge)
        orbits.bottom = height.subtractPadding()
        orbits.textDropShadow()
        
        // subthought count
        subThoughtCount.text = "\(thought.subThoughts.count) Sub Thoughts"
        subThoughtCount.sizeToFit()
        subThoughtCount.textColor = Colors.primaryGreen
        subThoughtCount.underline()
        subThoughtCount.left = Styles.Padding.xLarge.rawValue
        subThoughtCount.bottom = height.subtractPadding(.xLarge)
        
    }
}
