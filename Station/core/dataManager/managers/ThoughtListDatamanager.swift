
import UIKit
import CoreData
import CoreLocation

class ThoughtListDataManager: DataManager {

    public var delegate: DataManagerDelegate?
    private var isSearching = false
    internal var moc: NSManagedObjectContext
    
    required init(moc: NSManagedObjectContext) {
        self.moc = moc
        thoughts = getThoughts()
    }
    
    public func refresh() {
        thoughts = []
        thoughts = getThoughts()
    }
    
    private var thoughts: [Thought] = []
    private var filteredThoughts: [Thought] = []
    
    public var displayableThoughts: [Thought] {
        if isSearching {
            return filteredThoughts
        }
        return thoughts
    }
    
}

// all DM accessing methods
extension ThoughtListDataManager {
    
    // filter
    func filterThoughts(_ predicate: String) {
        if predicate != "" {
            isSearching = true
            filteredThoughts = thoughts.filter({ (thought) -> Bool in
                thought.title.lowercased().contains(predicate)
            })
        } else { isSearching = false }
    }
    
    // sort
    func sort(by option: SortOption) {
        switch option {
        case .dateAscending:
            thoughts.sort { (t1, t2) -> Bool in
                t1.createdAt < t2.createdAt
            }
        case .dateDescending:
            thoughts.sort { (t1, t2) -> Bool in
                t1.createdAt > t2.createdAt
            }
        case .subThoughtAscending:
            thoughts.sort { (t1, t2) -> Bool in
                t1.computedSubThoughts.count < t2.computedSubThoughts.count
            }
        case .subThoughtDescending:
            thoughts.sort { (t1, t2) -> Bool in
                t1.computedSubThoughts.count < t2.computedSubThoughts.count
            }
        }
        
    }
}

extension ThoughtListDataManager: ThoughtDataAccessable {
    
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
