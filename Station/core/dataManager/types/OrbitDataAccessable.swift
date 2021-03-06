
import CoreLocation

protocol OrbitDataAccessable: DataManager { }

extension OrbitDataAccessable {
    
    internal func getAllOrbits(batchSize: Int) -> [Orbit] {
        let request = Orbit.sortedFetchRequest
        request.fetchBatchSize = batchSize
        request.fetchLimit = batchSize
        request.shouldRefreshRefetchedObjects = true
        request.returnsObjectsAsFaults = false
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            return try moc.fetch(request)
            
        } catch { return [] }
    }
    
    public func createOrbit(withTitle title: String, andIcon icon: String) {
        
        _ = Orbit.insert(into: moc, with: icon, and: title)
        _ = moc.saveOrRollback()
        
        refresh()
        
    }
}


