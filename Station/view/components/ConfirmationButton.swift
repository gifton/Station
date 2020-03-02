
import UIKit

// confirmatino button is a simple generic full-width button that displays desired text with either light/dark/ monochrom color options

enum ConfirmButtonColor {
    case light, regular, monoChrome
}

enum ConfirmationButtonWidth: Int {
    case full = 1
    case half = 2
}

class ConfirmationButton: UIButton {
    init(point: CGPoint, color: ConfirmButtonColor = .light, text: String, width widthType: ConfirmationButtonWidth = .full) {
        super.init(frame: CGRect(origin: point, size: CGSize((Device.width / CGFloat(widthType.rawValue)).subtractPadding(multiplier: 2), 50)))
        
        setTitle(text, for: .normal)
        
        switch color {
        case .regular:
            backgroundColor = Styles.Colors.primaryBlue
            setTitleColor(Styles.Colors.offWhite, for: .normal)
        case .light:
            backgroundColor = Styles.Colors.lightGray
            setTitleColor(Styles.Colors.black.withAlphaComponent(0.8), for: .normal)
        case .monoChrome:
            backgroundColor = .black
            setTitleColor(Styles.Colors.offWhite, for: .normal)
        }
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
