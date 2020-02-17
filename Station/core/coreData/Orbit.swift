

import CoreData

@objc(Orbit)
public class Orbit: NSManagedObject {
    
    @NSManaged public var title: String
    @NSManaged public var createdAt: Date
    @NSManaged public var icon: String
    @NSManaged public var id: String
    
    @NSManaged public var thoughts: NSSet?
    
    
}


// builder methods

extension Orbit {
    static func insert(into moc: NSManagedObjectContext, with icon: String, and title: String) -> Orbit {
        
        let orbit: Orbit = moc.insertObject()
        orbit.id = UserDefaults.creatednewOrbit()
        orbit.title = title
        orbit.icon = icon
        orbit.createdAt = Date()
        
        return orbit
        
    }
    
    var count: Int {
        return relatedThoughts?.count ?? 0
    }
    
    var relatedThoughts: [Thought]? {
        
        guard let thoughts = thoughts else { return nil }
        
        return thoughts.map {
            $0 as! Thought
        }
        
//         this is a backup implementation to be used if the map {} method doesnt work in testing
//        var out = [Thought]()
//        for t in thoughts {
//            if let thought = t as? Thought {
//                out.append(thought)
//            }
//        }
//
//        return out
    }
    
}



extension Orbit: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createdAt), ascending: false)]
    }
}


extension Array where Element == Orbit {
    func addThoughtRelationship(_ thought: Thought) {
        forEach {
            if let thoughts = $0.thoughts {
                thoughts.adding(thought)
            }
        }
    }
}
