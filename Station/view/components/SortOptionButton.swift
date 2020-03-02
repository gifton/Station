
import UIKit




enum SortOption: String {
    case dateAscending = "Date ascending"
    case dateDescending = "Date Descending"
    case subThoughtAscending = "Sub Thought count ascending"
    case subThoughtDescending = "Sub Thought count descending"
    
    static var all: [SortOption] { return [.dateAscending, .dateDescending, .subThoughtAscending, .subThoughtDescending]}
}

class SortOptionButton: UIButton {
    init(point: CGPoint, option: SortOption) {
        self.option = option
        super.init(frame: CGRect(origin: point, size: CGSize(Device.width.subtractPadding(.xLarge, multiplier: 2), 42)))
        
        setTitle(option.rawValue, for: .normal)
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        setButton()
        
        
    }
    
    private var option: SortOption
    
    public func selected() {
        
        backgroundColor = Styles.Colors.primaryBlue
        setTitleColor(Styles.Colors.lightGray, for: .normal)
    }
    
    private func setButton() {
        
        backgroundColor = Styles.Colors.lightGray
        setTitleColor(Styles.Colors.primaryBlue, for: .normal)
            
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

