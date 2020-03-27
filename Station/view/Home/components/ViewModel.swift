
import CoreData

protocol ViewModel: class {
    var moc: NSManagedObjectContext { get }
    func update()
    init(moc: NSManagedObjectContext)
}


protocol ViewModelDelegate: UIController {
    func dataRecieved()
    var previewType: PreviewType { get }
}

protocol ViewModelTableDataSource: ViewModel {
    func loadedPreview(forIndex index: Int) -> DataPreview?
    var count: Int { get }
}

protocol ViewModelFilterDelegate: ViewModel {
    func sort(withOption option: SortOption)
    func filter(withPredicate predicate: String)
    func clear()
}

extension ViewModelFilterDelegate {
    func sort(array: inout [DataPreview], sort: SortOption) {
        
    }
    
    func filter(array: [DataPreview], predicate: String)  {
        
    }
}
extension ViewModel {
    
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
    
    func createThought(fromTitle title: String, andOrbits orbits: [Orbit]?) {
        print("creating thought with  title:  \(title) and orbit count: \(orbits?.count ?? 0)")
        let t = Thought.insert(in: moc, title: title, location: nil, orbits: orbits)
        orbits?.addThoughtRelationship(t)
        _ = moc.saveOrRollback()
    }
}
