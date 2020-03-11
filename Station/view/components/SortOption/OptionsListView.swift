
import UIKit

protocol SortOptionsListDelegate: Controller {
    func didSelect(option: SortOption)
    var selectedOption: SortOption { get }
    func setSort(option: SortOption)
}


final class SortOptionListView: UIView {
    
    init(withDelegate delegate: SortOptionsListDelegate) {
        self.delegate = delegate
        super.init(frame: .init(origin: .zero, size: .init(Device.width, 300)))
        
        backgroundColor = .white
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate: SortOptionsListDelegate
}

private extension SortOptionListView {
    
    func setView() {
        
        let title = UILabel.mediumTitle("Sort", .large)
        let icon = Icons.iv(withImageType: .sort, size: .medium)
        
        addSubview(title)
        addSubview(icon)
        
        title.sizeToFit()
        title.frame.origin = .init(Styles.Padding.large.rawValue)
        icon.top = Styles.Padding.large.rawValue
        icon.right = right.subtractPadding(.large)
    
        var startY = title.bottom.addPadding(.xXLarge)
        
        for option in SortOption.all {
            
            let btn = SortOptionButton(point: .init(Styles.Padding.xLarge.rawValue, startY), option: option)
            btn.addTapGestureRecognizer {
                self.didSelect(option: option) { (animate) in
                    if animate { btn.animate() }
                }
                
            }
            
            if option == delegate.selectedOption {
                btn.selected()
            }
            
            addSubview(btn)
            startY = btn.bottom.addPadding(.small)
            
        }
        
        
        
    }
    
    func didSelect(option:  SortOption, completion: (Bool) -> ()) {
        if !(delegate.selectedOption == option) {
            delegate.didSelect(option: option)
            completion(false)
        } else {
            
            completion(true)
            
        }
        
        
    }
}
