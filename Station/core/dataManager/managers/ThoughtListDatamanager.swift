
import UIKit
import CoreData
import CoreLocation

class ThoughtLIstDataManager: DataManager {

    var delegate: DataManagerDelegate?
    
    var moc: NSManagedObjectContext
    
    required init(moc: NSManagedObjectContext) {
        self.moc = moc
        thoughts = getThoughts()
    }
    
    private var thoughts: [Thought] = []
    private var filteredThoughts: [Thought] = []
    
    public var displayableThoughts: [Thought] = []
    
}

extension ThoughtLIstDataManager: ThoughtDataAccessable {
    
    func getThoughts() -> [Thought] {
        
        let request = Thought.sortedFetchRequest
        request.fetchBatchSize = 100
        request.shouldRefreshRefetchedObjects = true
        request.returnsObjectsAsFaults = false
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            return try moc.fetch(request)
            
        } catch { return [] }
    }
    
    func createThought(fromTitle title: String, withLocation: CLLocation?, andOrbits orbits: [Orbit]?) { }
    
    
}
