
import UIKit

protocol TopicSliverDelegate: UIController {
//    func topic(forRow: Int) -> Orbit
//    func didSelectTopic(_ topic: Orbit)
    func willDisplay(withWidth: SliverWidth)
    func willEndDisplay()
    
}

enum SliverWidth: CGFloat {
    case small
    case large
    
    static func calculated(_ width: SliverWidth) -> CGFloat {
        if width == .small {
            return  Device.width / 3
        } else {
            return  Device.width / 2
        }
    }
}


class TopicSliver: UIView {
    init(width: SliverWidth) {
        
        super.init(frame: CGRect(origin: .zero, size: .init(SliverWidth.calculated(width), Device.height)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
            self.backgroundColor = Colors.primaryRed
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
