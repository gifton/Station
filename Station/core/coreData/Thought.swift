
import CoreData
import UIKit
import CoreLocation

// thought marks basic building block of Station
// thoughts can have subthoughts, and orbits that define its content
@objc(Thought)
public class Thought: NSManagedObject {

    // MARK: Core Data properties
    @NSManaged public var title: String
    @NSManaged public var createdAt: Date
    @NSManaged public var id: String
    @NSManaged public var latitude: NSNumber?
    @NSManaged public var longitude: NSNumber?
    
    @NSManaged public var subThoughts: NSSet?
    @NSManaged public var orbits: NSSet?
    
}

// MARK: computed properties
extension Thought {
    //return location as CLLocation
    public var location: CLLocation? {
        guard let lat = latitude, let lon = longitude else { return nil }
        return CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue)
    }
    
    // get all computed orbits
    public var computedOrbits: [Orbit] {
        if let orbits = orbits as? Set<Orbit> {
            return orbits.sorted { (o1, o2) -> Bool in
                o1.createdAt > o2.createdAt
            }
        }
        return []
    }

    public var computedSubThoughts: [SubThought] {
        if let sb = subThoughts {
            return sb.map {
                $0 as! SubThought
            }
        }
        return []
    }
}

// MARK: static initializer
extension Thought {
    
    //build thought components
    static func insert(in context: NSManagedObjectContext, title: String, location: CLLocation?, orbits: [Orbit]?) -> Thought {
        
        //set new thought from context
        let thought: Thought = context.insertObject()
        
        // set variables
        thought.title      = title
        thought.createdAt  = Date()
        thought.id         = UserDefaults.createdNewThought()
        print(thought.id)
        //save location if available
        if let loc: CLLocation = location {
            thought.latitude  = loc.coordinate.latitude as NSNumber
            thought.longitude = loc.coordinate.longitude as NSNumber
        }
        
        if let orbits = orbits {
            thought.orbits = NSSet(array: orbits)
        }
        
        
        print(thought.createdAt)
        return thought
    }
    
    // cerate from preview
    static func insert(in context: NSManagedObjectContext, with preview: ThoughtPreview) -> Thought {
        return Thought.insert(in: context, title: preview.title, location: preview.location, orbits: preview.orbits)
    }
    
    // TODO: test
    public func addOrbit(_ orbit: Orbit) {
        
        // check if set is nill, set to empty list if so
        if subThoughts == nil {
            orbits = []
        }
        
//        (subThoughts as? NSSet<Orbit>)?.
        
        subThoughts?.adding(orbit)
        print("added orbit to thought")
    }
}

// MARK: Thoguht conformance to managed
extension Thought: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createdAt), ascending: false)]
    }
}

// thought array helpers
extension Array where Element == Orbit {
    func icons() -> [String] {
        return map { $0.icon }
    }
}
