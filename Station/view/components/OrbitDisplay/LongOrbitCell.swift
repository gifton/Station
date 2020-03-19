

import UIKit

// MARK: LongOrbitCell object
// displays orbit cell of maximum length for device
final class LongOrbitCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    // private vars
    private var orbit: Orbit?
    private var rightStack: UIStackView!
    private var leftStack: UIStackView!
    private var arrow: UIImageView!
    private var count: UILabel!
    private var icon: UILabel!
    private var title: UILabel!
    
    // set data
    public func set(withOrbit orbit: Orbit) {
        self.orbit = orbit
        
        layer.cornerRadius = 8
        layer.borderColor = Colors.lightGray.cgColor
        layer.borderWidth = 1
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: Builder methods
private extension LongOrbitCell {
    func setView() {
        guard let orbit = orbit else { return }
        
        // create views
        arrow = Icons.iconView(withImageType: .arrow, size: .small, color: Colors.darkGray.withAlphaComponent(0.4))
        arrow.image = arrow.image?.rotate(radians: -(.pi))
        count = UILabel.body(String(describing: 55), .large)
        icon = UILabel.body(orbit.icon, .large)
        title = UILabel.body(orbit.title, .large)
        
        count.sizeToFit()
        icon.sizeToFit()
        title.sizeToFit()
        
        rightStack = UIStackView(arrangedSubviews: [count, arrow], axis: .horizontal, spacing: 8, alignment: .trailing, distribution: .equalSpacing)
        leftStack = UIStackView(arrangedSubviews: [icon, title], axis: .horizontal, spacing: 15, alignment: .leading, distribution: .equalCentering)
        
        // add views
        addSubview(rightStack)
        addSubview(leftStack)
        
        rightStack.frame.size = .init(count.width + arrow.width + 20, max(count.height, arrow.height))
        rightStack.center.y = height/2
        rightStack.right = right.subtractPadding()
        leftStack.frame.size = .init(title.width + 25 + 10, max(icon.height, title.height))
        leftStack.left = 25
        leftStack.center.y = height/2
        
        
        // style views
        count.textColor = Colors.primaryBlue
        title.textColor = Colors.secondaryGray
    }
}
