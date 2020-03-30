
import UIKit

class TopicSliverCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var topic: Orbit?
    
    public func set(withTopic topic: Orbit) {
        self.topic = topic
        setCell()
    }
    
    public func hasBeenSelected(_ selected: Bool) {
        if selected {
            backgroundColor = Colors.primaryBlue
        } else {
            Colors.white.withAlphaComponent(0.6)
        }
    }
}

private extension TopicSliverCell {
    func setCell() {
        
    }
    
}
