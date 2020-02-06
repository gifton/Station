
import UIKit

// confirmatino button is a simple generic full-width button that displays desired text with either light/dark/ monochrom color options

enum ConfirmButtonColor {
    case light, regular, monoChrome
}


class ConfirmationButton: UIButton {
    init(point: CGPoint, color: ConfirmButtonColor = .light, text: String) {
        super.init(frame: CGRect(origin: point, size: CGSize(Styles.width - (Styles.Padding.large.rawValue * 2), 50)))
        
        setTitle(text, for: .normal)
        
        switch color {
        case .regular:
            backgroundColor = Styles.Colors.primaryBlue
            setTitleColor(Styles.Colors.offWhite, for: .normal)
        case .light:
            backgroundColor = Styles.Colors.lightGray
            setTitleColor(.darkGray, for: .normal)
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
