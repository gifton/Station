
import UIKit

protocol TopicSliverDelegate: UIController {
//    func topic(forRow: Int) -> Orbit
//    func didSelectTopic(_ topic: Orbit)
    func willDisplay(withWidth: SliverWidth)
    func willEndDisplay()
    
}

enum SliverWidth: CGFloat {
    case small = 150
    case large = 270.0
}


class TopicSliver: UIView {
    init(width: SliverWidth) {
        sliverWidth = width
        super.init(frame: CGRect(origin: .zero, size: .init(width.rawValue, Device.height)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var sliverWidth: SliverWidth
    var delegate: TopicSliverDelegate?
}

extension TopicSliver {
    func willDisplay() {
        UIView.animate(withDuration: 0.25) {
            self.backgroundColor = Colors.lightGray
        }
    }
    
    func endDisplay(onComplete: @escaping () -> () ) {
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundColor = Colors.bglightClay
        }) { (out) in
            onComplete()
        }
    }
}

private extension TopicSliver {
    func setView() {
        backgroundColor = .darkGray
        
    }
}
