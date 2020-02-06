
import UIKit

// new orbit cells have 2 types; Circular and inline


class CircularNewOrbitCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Styles.Colors.primaryBlue
        layer.cornerRadius = height / 2
        
        let lbl = UILabel("+")
        lbl.font = Styles.Font.body(ofSize: .medium)
        lbl.textColor = Styles.Colors.offWhite
        lbl.sizeToFit()
        lbl.frame.origin = .zero
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class inlineNewOrbitCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Styles.Colors.primaryBlue
        layer.cornerRadius = 8
        let lbl = UILabel.titleLabel("new", .large)
        lbl.textColor = Styles.Colors.offWhite
        lbl.textAlignment = .center
        addSubview(lbl)
        lbl.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

