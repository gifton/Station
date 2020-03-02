import CoreData

// container for loading aplpication into Core data context
// Container creation is application-leve and should encapsulate window initialization && AppCoordinator.start() methods
func createThoughtContainer(completion: @escaping (NSPersistentContainer) -> Void) {
    
    let container = NSPersistentContainer(name: "rt-db4")
    
    container.loadPersistentStores { (_, error) in
        
        guard error == nil else { fatalError("failed to load store: \(error!)")}
        
        DispatchQueue.main.async { completion(container) }
    }
    
}
