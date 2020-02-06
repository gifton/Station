import CoreData
import UIKit
import CoreLocation

@objc(SubThought)
public class SubThought: NSManagedObject {
    
    // MARK: Core Data properties
    @NSManaged public var note: String?
    @NSManaged public var createdAt: Date
    @NSManaged public var link: String?
    @NSManaged public var id: String
    @NSManaged public var rawImage: Data?
    
    @NSManaged public var thought: Thought
    
}

extension SubThought {
    // claculated variabls
    var subThoughtType: SubThoughtType {
        if note != nil { return .note }
        else if rawImage != nil { return .image }
        else { return .link }
    }
    
}

// builder methods
// Sub thought creation is delegated to the subthought object
// instead of having
extension SubThought {
    
    static func insertWithImage(into moc: NSManagedObjectContext, with component: UIImage, for thought: Thought) -> SubThought {
        let subThought: SubThought = moc.insertObject()
        
        subThought.rawImage = component.jpegData(compressionQuality: 1.0)
        subThought.thought = thought
        subThought.createdAt = Date()
        subThought.id = UserDefaults.createdNewSubThought(forThoughtID: thought.id)
        
        return subThought
    }
    
    static func insertWithNote(into moc: NSManagedObjectContext, with component: String, for thought: Thought) -> SubThought {
        let subThought: SubThought = moc.insertObject()
        
        subThought.note = component
        subThought.thought = thought
        subThought.createdAt = Date()
        subThought.id = UserDefaults.createdNewSubThought(forThoughtID: thought.id)
        
        return subThought
    }
    
    static func insertWithLink(into moc: NSManagedObjectContext, with component: String, for thought: Thought) -> SubThought {
        let subThought: SubThought = moc.insertObject()
        
        subThought.link = component
        subThought.thought = thought
        subThought.createdAt = Date()
        subThought.id = UserDefaults.createdNewSubThought(forThoughtID: thought.id)
        
        return subThought
    }
}


enum SubThoughtType {
    case note, image, link
}


extension SubThought: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createdAt), ascending: false)]
    }
}

