
import UIKit
// orbit cell includes title and icon
// optional: thoughtCount && arrow

class OrbitCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.borderColor = Styles.Colors.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // private var
    private(set) var orbit: Orbit?

    // UI Obects
    let iconView = UILabel()
    let title = UILabel.bodyLabel()
    public func set(withOrbit orbit: Orbit) {
        self.orbit = orbit
        setView()
    }
    
    deinit {
        
        iconView.text = ""
        title.text = ""
        
    }
    
    // controller calls method on tap
    public func didGetSelected() {
        print("orbit selected in cell")
        if backgroundColor == .clear {
            backgroundColor = Styles.Colors.accentBlue
        } else {
            backgroundColor = .clear
        }
    }
    
}

private extension  OrbitCell {
    func setView() {        
        
        addSubview(iconView)
        addSubview(title)
        
        iconView.frame = CGRect(x: Styles.Padding.small.rawValue, y: Styles.Padding.small.rawValue, width: 40, height: 40)
        iconView.padding = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        iconView.adjustsFontSizeToFitWidth = true
        iconView.backgroundColor = Styles.Colors.lightGray
        iconView.textAlignment = .center
        iconView.layer.cornerRadius = 4
        iconView.layer.masksToBounds = true
        
        guard let orbit = orbit else { return }
        
        iconView.text = orbit.icon
        title.text = orbit.title
        
        title.frame = CGRect(x: iconView.right + Styles.Padding.medium.rawValue, y: 0, width: width - (iconView.right + (Styles.Padding.medium.rawValue * 2)), height: height)
        title.adjustsFontSizeToFitWidth = true
        title.textAlignment = .center
    }
    
}