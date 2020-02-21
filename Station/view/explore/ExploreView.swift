
import UIKit

class ExploreView: UIScrollView {
    init() {
        super.init(frame: Device.frame)
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var header = UIView()
}
