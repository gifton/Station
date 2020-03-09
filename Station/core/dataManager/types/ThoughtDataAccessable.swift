
import CoreLocation

protocol ThoughtDataAccessable: DataManager {

}


extension ThoughtDataAccessable {
    
    internal func getThoughts(batchSize: Int) -> [Thought] {
        let request = Thought.sortedFetchRequest
        request.fetchBatchSize = batchSize
        request.shouldRefreshRefetchedObjects = true
        request.returnsObjectsAsFaults = false
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            let out = try moc.fetch(request)
            
            return out
            
        } catch { return [] }
    }
    
    func createThought(fromTitle title: String, withLocation: CLLocation?, andOrbits orbits: [Orbit]?) {
        print("creating thought with  title:  \(title) and orbit count: \(orbits?.count ?? 0)")
        let t = Thought.insert(in: moc, title: title, location: CLLocation(), orbits: orbits)
        orbits?.addThoughtRelationship(t)
        _ = moc.saveOrRollback()
    }
}
