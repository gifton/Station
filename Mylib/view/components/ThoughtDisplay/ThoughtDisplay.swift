
import UIKit

protocol ThoughtDisplayDelegate {
    var thoughts: [ThoughtPreview]
}

class ThoughtDisplay: UIView {
    init(point: CGPoint, title: Bool = true, delegate: ThoughtDisplayDelegate) {
        super.init(frame: CGRect(origin: point, size: .init(Device.width, 155 + Styles.Padding.small.rawValue + (title ? 25 : 0 ))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
