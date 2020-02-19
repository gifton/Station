
import UIKit
import CoreLocation


class ThoughtListController: Controller {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = Styles.Colors.offWhite
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var display: ThoughtDisplay?
}


extension ThoughtListController: ThoughtDisplayDelegate {
    var thoughts: [ThoughtPreview] {
        get {
            if let dm = (dataManager as? ThoughtLIstDataManager) {
                return dm.displayableThoughts.toPreview()
            } else {
                return []
            }
        }
    }
    
    func selectedThought(atIndex index: Int) {
        print("tohught at index: \(index) selected")
    }
    
}


private extension ThoughtListController {
    func setView() {
        display = ThoughtDisplay(point: .init(0, 25), title: true, delegate: self)
        view.addSubview(display!)
    }
}
