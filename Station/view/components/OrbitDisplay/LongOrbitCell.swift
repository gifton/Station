

import UIKit

// MARK: LongOrbitCell object
// displays orbit cell of maximum length for device
final class LongOrbitCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    // private vars
    private var orbit: OrbitPreview?
    private var rightStack: UIStackView!
    private var leftStack: UIStackView!
    private var arrow: UIImageView!
    private var count: UILabel!
    private var icon: UILabel!
    private var title: UILabel!
    
    // set data
    public func set(withOrbit orbit: OrbitPreview) {
        self.orbit = orbit
        
        layer.cornerRadius = 8
        layer.borderColor = Styles.Colors.lightGray.cgColor
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
        arrow = UIImageView(image: UIImage(systemName: "heart.fill"))
        count = UILabel.bodyLabel(String(describing: 55), .large)
        icon = UILabel.bodyLabel(orbit.icon, .large)
        title = UILabel.bodyLabel(orbit.title, .large)
        
        arrow.frame.size = .init(20)
        count.sizeToFit()
        icon.sizeToFit()
        title.sizeToFit()
        
        rightStack = UIStackView(arrangedSubviews: [count, arrow], axis: .horizontal, spacing: 8, alignment: .trailing, distribution: .equalSpacing)
        leftStack = UIStackView(arrangedSubviews: [icon, title], axis: .horizontal, spacing: 15, alignment: .leading, distribution: .equalCentering)
        
        // add views
        addSubview(rightStack)
        addSubview(leftStack)
        
        rightStack.frame.size = .init(count.width + arrow.width + 10,max(count.height, arrow.height))
        rightStack.right = right - Styles.Padding.large.rawValue
        rightStack.centerY = height / 2
        leftStack.frame.size = .init(title.width + 25 + 10, max(icon.height, title.height))
        leftStack.left = 25
        leftStack.centerY = height / 2
        
        
        // style views
        count.textColor = Styles.Colors.primaryBlue
        title.textColor = Styles.Colors.secondaryGray
    }
}