

import CoreData

// orbit object relates different thoughts to a specific topic
// user creates Orbits to classify specific thoughts 
@objc(Orbit)
public class Orbit: NSManagedObject {
    
    // public vars
    @NSManaged public var title: String
    @NSManaged public var createdAt: Date
    @NSManaged public var icon: String
    @NSManaged public var id: String
    
    @NSManaged public var thoughts: NSSet?
    
    
}


// builder methods
extension Orbit {
    // create new orbit
    static func insert(into moc: NSManagedObjectContext, with icon: String, and title: String) -> Orbit {
        
        let orbit: Orbit = moc.insertObject()
        orbit.id = UserDefaults.creatednewOrbit()
        orbit.title = title
        orbit.icon = icon
        orbit.createdAt = Date()
        
        return orbit
        
    }
    
    // return number of thoughts with orbit
    var count: Int {
        return relatedThoughts?.count ?? 0
    }
    
    // return all thoughts with related orbit
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


// MARK: managed conformance
extension Orbit: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createdAt), ascending: false)]
    }
}

// Mark: adding thought relation to orbit 
extension Array where Element == Orbit {
    func addThoughtRelationship(_ thought: Thought) {
        forEach {
            if let thoughts = $0.thoughts {
                thoughts.adding(thought)
            }
        }
    }
    
    // return icons for list of orbits
    func getAllIcons() -> [String] {
        return map {
            $0.icon
        }
    }
}
