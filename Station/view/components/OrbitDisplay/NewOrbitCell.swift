
import UIKit

// new orbit cells have 2 types; Circular and inline
// MARK: CircularOrbitCell
class CircularNewOrbitCell: UICollectionViewCell {
    // simple impletation negates need for private extensions
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Styles.Colors.white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = height / 2
        
        let lbl = UILabel("+")
        lbl.font = Styles.Font.body(ofSize: .xLarge)
        lbl.textColor = Styles.Colors.black
        
        lbl.sizeToFit()
        lbl.frame.center = .init(width / 2, height / 2)
        
        addSubview(lbl)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Inline OrbitCell
class inlineNewOrbitCell: UICollectionViewCell {
    // simple impletation negates need for private extensions
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Styles.Colors.primaryBlue
        layer.cornerRadius = 8
        let lbl = UILabel.title("new", .large)
        lbl.textColor = Styles.Colors.offWhite
        lbl.textAlignment = .center
        addSubview(lbl)
        lbl.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

