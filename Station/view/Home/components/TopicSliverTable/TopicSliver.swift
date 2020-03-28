
import UIKit

protocol TopicSliverDelegate: UIController {
    func topic(forRow: Int) -> Orbit
    func didSelectTopic(_ topic: Orbit)
    func willDisplay()
    func willEndDisplay()
    
}
