
import CoreData
import UIKit
import CoreLocation

class NewThoughtDataManager: DataManager {

    
    var delegate: DataManagerDelegate?
    
    required init(moc: NSManagedObjectContext) {
        self.moc = moc
        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Orbit")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try moc.execute(deleteRequest)
//            
//        } catch let error as NSError { print(error) }

        
        orbits = getOrbits()
        
        
    }
    
    private(set) var moc: NSManagedObjectContext
    private(set) var orbits: [Orbit] = []
    private(set) var filteredOrbits: [Orbit] = []
    private var isSearching: Bool = false
    
    public var displayableOrbits: [Orbit] {
        if isSearching {
            return filteredOrbits
        } else {
            return orbits
        }
    }
    
    func refresh() {
        orbits = []
        orbits = getOrbits()
    }
    
    func filterOrbits(_ predicate: String) {
        if predicate != "" {
            isSearching = true
            filteredOrbits = orbits.filter({ (orbit) -> Bool in
                orbit.title.lowercased().contains(predicate)
            })
        } else { isSearching = false }
    }
}


extension NewThoughtDataManager: ThoughtDataAccessable {
    func getThoughts() -> [Thought] { return [] }
    
    func createThought(fromTitle title: String, withLocation: CLLocation?, andOrbits orbits: [Orbit]?) {
        
        print("creating thought with  title:  \(title) and orbit count: \(orbits?.count ?? 0)")
        let t = Thought.insert(in: moc, title: title, location: CLLocation(), orbits: orbits)
        orbits?.addThoughtRelationship(t)
        _ = moc.saveOrRollback()
        
    }
    
}

extension NewThoughtDataManager: OrbitDataAccessable {
    
    func getOrbits() -> [Orbit] {
        let request = Orbit.sortedFetchRequest
        request.fetchBatchSize = 100
        request.shouldRefreshRefetchedObjects = true
        request.returnsObjectsAsFaults = false
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            return try moc.fetch(request)
            
        } catch { return [] }
    }
    
    func createOrbit(withTitle title: String, andIcon icon: String) {
        
        _ = Orbit.insert(into: moc, with: icon, and: title)
        _ = moc.saveOrRollback()
        
        refresh()
        
    }
    
}

extension NewThoughtDataManager: LocationDataAccessable {
    
    var locationDataIsAvailable: Bool {
        return UserDefaults.isLocationAvailable
    }
    
    func requestAuthorization() -> CLLocation? {
        return delegate?.requestLocation()
    }
    
    
}
