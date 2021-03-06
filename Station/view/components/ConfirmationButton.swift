
import UIKit

// confirmatino button is a simple generic full-width button that displays desired text with either light/dark/ monochrom color options

enum ConfirmButtonColor {
    case light, regular, monoChrome
}

enum ConfirmationButtonWidth: Int {
    case full = 1
    case half = 2
    case third = 3
}

final class ConfirmationButton: UIButton {
    init(point: CGPoint, color: ConfirmButtonColor = .light, text: String, width widthType: ConfirmationButtonWidth = .full, font: UIFont = Styles.Font.mediumTitle(ofSize: .xXLarge)) {
        super.init(frame: CGRect(origin: point, size: CGSize((Device.width / CGFloat(widthType.rawValue)).subtractPadding(multiplier: 2), 50)))
        
        setTitle(text, for: .normal)
        titleLabel?.font = font
        titleLabel?.numberOfLines = 2
        
        switch color {
        case .regular:
            backgroundColor = Colors.primaryBlue
            setTitleColor(Colors.offWhite, for: .normal)
        case .light:
            backgroundColor = Colors.lightGray
            setTitleColor(Colors.black.withAlphaComponent(0.8), for: .normal)
        case .monoChrome:
            backgroundColor = .black
            setTitleColor(Colors.offWhite, for: .normal)
        }
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
