
import CoreData
import UIKit
import CoreLocation

class NewThoughtDataManager: DataManager {
    
    func start(completion: (() -> ())?) { }
    
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
    
    func refresh() {
        orbits = []
        orbits = getOrbits()
    }
}


extension NewThoughtDataManager: ThoughtDataAccessable {
    func getThoughts(withOrbitPredicate: Orbit?) -> [Thought] {
        return []
    }
    
    func createThought(fromTitle title: String, withLocation: CLLocation?, andOrbits orbits: [Orbit]?) {
        
        print("creating thought with  title:  \(title)")
        let t = Thought.insert(in: moc, title: title, location: CLLocation())
        orbits?.addThoughtRelationship(t)
        
        do {
            try moc.save()
            print("saved tought")
        } catch let err { print(err)}
        
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
            let out = try moc.fetch(request)
            print("------")
            print(out.count)
            return out
            
        } catch { return [] }
    }
    
    func createOrbit(withTitle title: String, andIcon icon: String) {
        
        print("creating orbit with  title:  \(title) and icon: \(icon)")
        
        _ = Orbit.insert(into: moc, with: icon, and: title)
        
        do {
            try moc.save()
            print("saved tought")
        } catch let err { print(err)}
        
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
