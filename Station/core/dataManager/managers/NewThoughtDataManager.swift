
import CoreData
import UIKit
import CoreLocation

// MARK: NewThought DM 
// displays all available orbits for search/filtering
// hadles creation of new Thought && Orbit objects
 
final class NewThoughtDataManager: DataManager {

    
    weak var delegate: DataManagerDelegate?
    
    required init(moc: NSManagedObjectContext) {
        self.moc = moc
        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Orbit")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try moc.execute(deleteRequest)
//            
//        } catch let error as NSError { print(error) }

        
        orbits = getAllOrbits(batchSize: 500)
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
        orbits = getAllOrbits(batchSize: 500)
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


extension NewThoughtDataManager: ThoughtDataAccessable {}

extension NewThoughtDataManager: OrbitDataAccessable { }

extension NewThoughtDataManager: LocationDataAccessable {
    
    var locationDataIsAvailable: Bool {
        return UserDefaults.isLocationAvailable
    }
    
    func requestAuthorization() -> CLLocation? {
        return delegate?.requestLocation()
    }
    
    
}
