
import UIKit

// subthought preview is used during creation process to decouple Core data from as many objects as possible
final class SubThoughtPreview: DataPreview {
    
    var note: String? {
        didSet { type = .note }
    }
    var image: UIImage? {
        didSet { type = .image }
    }
    var link: String? {
        didSet { type = .link }
    }
    var linkIcon: String?
    
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
            if let data = sb.rawPhoto, let img = UIImage(data: data) {
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
                preview = SubThoughtPreview(link: link, icon: sb.linkIcon, thought: sb.thought)
            } else {
                preview = SubThoughtPreview(link: "", icon: sb.linkIcon, thought: sb.thought)
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
        type = .image
    }
    
    init(link: String, icon: String?, thought: Thought?) {
        self.link = link
        self.thought = thought
        self.linkIcon = icon
        date = Date()
        type  = .link
    }
    
    var date: Date
    var type: SubThoughtType = .note
}

extension Array where Element == SubThought {
    func toPreview() -> [SubThoughtPreview] {
        return map { SubThoughtPreview.fromCoreObject($0) }
    }
}
