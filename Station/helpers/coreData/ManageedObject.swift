
import CoreData

extension NSManagedObjectContext {
    func insertObject<A: NSManagedObject>() -> A where A: Managed {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else { fatalError("Wrong object type") }
        return obj
    }
    
    func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            print("unable to save data... rolling back")
            rollback()
            return false
        }
    }
    
    func performChanges(block: @escaping (Bool) -> ()) {
        perform {
            block(self.saveOrRollback())
        }
    }
    
}


