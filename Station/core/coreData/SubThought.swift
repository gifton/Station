import CoreData
import UIKit
import CoreLocation

// subTHought allows user to continue their thought "process"
// subthoughts can be text, image or link
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
// Sub thought creation is delegated to the subthought object as apposed to inside thought itself
// this is done because in order to create sb in thought, the entire object has to be loaded into memory again (innefeciant)
extension SubThought {
    
    // photo subthought
    static func insertWithImage(into moc: NSManagedObjectContext, with component: UIImage, for thought: Thought) -> SubThought {
        let subThought: SubThought = moc.insertObject()
        
        subThought.rawImage = component.jpegData(compressionQuality: 1.0)
        subThought.thought = thought
        subThought.createdAt = Date()
        subThought.id = UserDefaults.createdNewSubThought(forThoughtID: thought.id)
        
        return subThought
    }
    
    // note subthought
    static func insertWithNote(into moc: NSManagedObjectContext, with component: String, for thought: Thought) -> SubThought {
        let subThought: SubThought = moc.insertObject()
        
        subThought.note = component
        subThought.thought = thought
        subThought.createdAt = Date()
        subThought.id = UserDefaults.createdNewSubThought(forThoughtID: thought.id)
        
        return subThought
    }
    
    // link subthought
    static func insertWithLink(into moc: NSManagedObjectContext, with component: String, for thought: Thought) -> SubThought {
        let subThought: SubThought = moc.insertObject()
        
        subThought.link = component
        subThought.thought = thought
        subThought.createdAt = Date()
        subThought.id = UserDefaults.createdNewSubThought(forThoughtID: thought.id)
        
        return subThought
    }
}

// MARK: subthought types
enum SubThoughtType {
    case note, image, link
}

// MARK: subthought managed conformnce
extension SubThought: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createdAt), ascending: false)]
    }
}

