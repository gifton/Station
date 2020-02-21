
import UIKit

// confirmatino button is a simple generic full-width button that displays desired text with either light/dark/ monochrom color options

protocol SortOptionDelegate {
    func didSelect(_ option: SortOption)
    var selectedOption: SortOption { get }
}



enum SortOption: String {
    case dateAscending = "Date ascending"
    case dateDescending = "Date Descending"
    case subThoughtAscending = "Sub Thought count ascending"
    case subThoughtDescending = "Sub Thought count descending"
}

class SortOptionButton: UIButton {
    init(point: CGPoint, option: SortOption) {
        self.option = option
        super.init(frame: CGRect(origin: point, size: CGSize(Styles.width.subtractPadding(.xLarge, multiplier: 2), 42)))
        
        setTitle(option.rawValue, for: .normal)
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        
        
    }
    
    var delegate: SortOptionDelegate? {
        didSet {
            setButton()
            
            addTapGestureRecognizer {
                self.delegate?.didSelect(self.option)
                self.setButton()
                
            }
            
        }
    }
    private var option: SortOption
    
    private func setButton() {
        if let del = delegate {
            if del.selectedOption == option {
                print("is the same")
                backgroundColor = Styles.Colors.primaryBlue
                setTitleColor(Styles.Colors.lightGray, for: .normal)
            } else {
                print("isnt the same")
                backgroundColor = Styles.Colors.lightGray
                setTitleColor(Styles.Colors.primaryBlue, for: .normal)
            }
        } else {
            print("couldnt get del")
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

