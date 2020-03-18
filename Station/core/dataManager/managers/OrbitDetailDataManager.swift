
import CoreData
import UIKit


final class OrbitDetailDataManager: DataManager {
    func refresh() {
        print("refreshing")
    }
    
    var delegate: DataManagerDelegate?
    var moc: NSManagedObjectContext
    var orbit: Orbit!
    init(moc: NSManagedObjectContext) {
        self.moc = moc
        
    }
    
    var thoughts: [Thought] {
        orbit.relatedThoughts ?? []
    }
    
    convenience init(moc: NSManagedObjectContext, orbit: Orbit) {
        self.init(moc: moc)
        self.orbit = orbit
        print(orbit.title)
        print(orbit.relatedThoughts)
    }
    
}


extension OrbitDetailDataManager: OrbitDataAccessable { }
