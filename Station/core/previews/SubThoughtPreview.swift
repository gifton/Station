
import UIKit

class SubThoughtPreview: DataPreview {
    
    var note: String? {
        didSet { type = .note }
    }
    var image: UIImage?{
        didSet { type = .image }
    }
    var link: String?{
        didSet { type = .link }
    }
    
    var thought: Thought

    init(fromThought thought: Thought) {
        self.thought = thought
    }
    
    convenience init(_ subThought: SubThought) {
        self.init(fromThought: subThought.thought)
        
        switch subThought.subThoughtType {
        case .note:
            note = subThought.note
        case .link:
            link = subThought.link
        case .image:
            if let img = subThought.rawImage {
                image = UIImage(data: img)
            }
        }
    }
    
    var type: SubThoughtType = .note
}
