
import CoreData
import UIKit
import CoreLocation

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
    
    var computedSubThoughts: [SubThought] {
        guard let subThoughts = subThoughts else { return [] }
        
        return subThoughts.map {
            $0 as! SubThought
        }
        
    }
}

// MARK: computed properties
extension Thought {
    //return location as CLLocation
    public var location: CLLocation? {
        guard let lat = latitude, let lon = longitude else { return nil }
        return CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue)
    }
    
}

// MARK: static initializer
extension Thought {
    
    //build thought components
    static func insert(in context: NSManagedObjectContext, title: String, location: CLLocation?) -> Thought {
        
        //set new thought from context
        let thought: Thought = context.insertObject()
        
        // set variables
        
        thought.title      = title
        thought.createdAt  = Date()
        thought.id         = UserDefaults.createdNewThought()
        
        //save location if available
        if let loc: CLLocation = location {
            thought.latitude  = loc.coordinate.latitude as NSNumber
            thought.longitude = loc.coordinate.longitude as NSNumber
        }
        
        
        return thought
    }
    
    static func insert(in context: NSManagedObjectContext, with preview: ThoughtPreview) -> Thought {
        return Thought.insert(in: context, title: preview.title, location: preview.location)
    }
}

// MARK: Thoguht conformance to managed
extension Thought: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createdAt), ascending: false)]
    }
}
