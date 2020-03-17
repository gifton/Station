
import UIKit

protocol SortOptionsListDelegate: Controller {
    func didSelect(option: SortOption)
    var selectedOption: SortOption { get }
    func setSort(option: SortOption)
}


final class SortOptionListView: UIView {
    
    init(withDelegate delegate: SortOptionsListDelegate) {
        self.delegate = delegate
        super.init(frame: .init(origin: .init(Styles.Padding.xLarge.rawValue, Device.height - Device.tabBarheight - 280), size: .init(Device.width.subtractPadding(.xLarge, multiplier: 2), 260)))
        
        layer.cornerRadius = 20
        backgroundColor = .white
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    unowned var delegate: SortOptionsListDelegate
}

private extension SortOptionListView {
    
    func setView() {
        
        // set title and icon
        let title = UILabel.mediumTitle("Sort", .large)
        let icon = Icons.iconView(withImageType: .sort, size: .medium)
        title.sizeToFit()
        addSubview(title)
        addSubview(icon)
        let stack = UIStackView(arrangedSubviews: [icon, title], axis: .horizontal, spacing: 5)
        stack.top = CGFloat(0).addPadding()
        stack.frame.size = .init(title.width + icon.width + 5, max(title.height, icon.height))
        stack.frame.center.x = width / 2
        addSubview(stack)
    
        // seet option buttons
        var startY = stack.bottom.addPadding(.xLarge)
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
