
import UIKit
import CoreLocation


class ThoughtListController: Controller {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .green
        
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
    
    
}
