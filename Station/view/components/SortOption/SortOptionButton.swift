
import UIKit




enum SortOption: String {
    case dateAscending = "Date ascending"
    case dateDescending = "Date Descending"
    case subThoughtAscending = "Sub Thought count ascending"
    case subThoughtDescending = "Sub Thought count descending"
    
    static var all: [SortOption] { return [.dateAscending, .dateDescending, .subThoughtAscending, .subThoughtDescending]}
}

final class SortOptionButton: UIButton {
    init(point: CGPoint, option: SortOption) {
        self.option = option
        super.init(frame: CGRect(origin: point, size: CGSize(Device.width.subtractPadding(.xXLarge, multiplier: 2), 42)))
        
        setTitle(option.rawValue, for: .normal)
        
        layer.cornerRadius = 16
        layer.masksToBounds = true
        setButton()
        
        
    }
    
    private var option: SortOption
    
    public func selected() {
        
        backgroundColor = Colors.primaryBlue
        setTitleColor(Colors.lightGray, for: .normal)
    }
    
    public func animate() {
        UIView.animate(withDuration: 0.15, animations: {
            self.backgroundColor = Colors.darkBlue
        }) { (_) in
            self.selected()
        }
    
    }
    
    private func setButton() {
        
        backgroundColor = Colors.lightGray
        setTitleColor(Colors.primaryBlue, for: .normal)
            
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

