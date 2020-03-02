
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
    
    var thought: Thought
    
    init(_ subThought: SubThought) {
        
        switch subThought.subThoughtType {
        case .note: note = subThought.note
        case .link: link = subThought.link
        case .image: if let img = subThought.rawImage { image = UIImage(data: img) }
        }
        thought = subThought.thought
        date = subThought.createdAt
    }
    var date: Date
    var type: SubThoughtType = .note
}
