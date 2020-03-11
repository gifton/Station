
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
    
    static func fromCoreObject(_ sb: SubThought) -> SubThoughtPreview {
        var preview: SubThoughtPreview!
        switch sb.subThoughtType {
        case .image:
            if let data = sb.rawImage, let img = UIImage(data: data) {
                preview = SubThoughtPreview(img: img, thought: sb.thought)
            } else {
                preview = SubThoughtPreview(img: UIImage(), thought: sb.thought)
            }
        case .note:
            if let note = sb.note {
                preview = SubThoughtPreview(text: note, thought: sb.thought)
            } else {
                preview = SubThoughtPreview(text: "", thought: sb.thought)
            }
        case .link:
            if let link = sb.link {
                preview = SubThoughtPreview(link: link, thought: sb.thought)
            } else {
                preview = SubThoughtPreview(link: "", thought: sb.thought)
            }
        }
        
        preview.date = sb.createdAt
        preview.type = sb.subThoughtType
        return preview
    }
    
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
