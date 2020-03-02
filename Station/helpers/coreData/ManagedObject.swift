
import CoreData

// MARL: NSManagedObject helper methods
extension NSManagedObjectContext {

    // insert single object into MOC after object materialized manually (usually after user-creation)
    func insertObject<A: NSManagedObject>() -> A where A: Managed {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else { fatalError("Wrong object type") }
        return obj
    }
    
    // safe-save for CoreData 
    // use case i.e: User does not have enough allocated memory remaining on disk to save item
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
    
    // safe saving method with returning (Bool) method for translation in DM or Controllers
    func performChanges(block: @escaping (Bool) -> ()) {
        perform {
            block(self.saveOrRollback())
        }
    }
    
}


