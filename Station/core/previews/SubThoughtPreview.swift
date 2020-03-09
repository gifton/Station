
import UIKit

// subthought preview is used during creation process to decouple Core data from as many objects as possible
class SubThoughtPreview: DataPreview {
    
    var note: String? {
        didSet { type = .note }
    }
    var image: UIImage? {
        didSet { type = .image }
    }
    var link: String? {
        didSet { type = .link }
    }
    
    var thought: Thought?
    
//    convenience init(_ subThought: SubThought) {
//
//        switch subThought.subThoughtType {
//        case .note: note = subThought.note
//        case .link: link = subThought.link
//        case .image: if let img = subThought.rawImage { image = UIImage(data: img) }
//        }
//
//        thought = subThought.thought
//        date = subThought.createdAt
//    }
    
    init(text: String, thought: Thought?) {
        self.note = text
        self.thought = thought
        date = Date()
    }
    
    init(img: UIImage, thought: Thought?) {
        self.image = img
        self.thought = thought
        date = Date()
    }
    
    init(link: String, thought: Thought?) {
        self.link = link
        self.thought = thought
        date = Date()
    }
    
    var date: Date
    var type: SubThoughtType = .note
}
