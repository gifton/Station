
import UIKit
import CoreData

class DashboardDataManager: DataManager {
    
    func start(completion: (() -> ())?) {
        print("starting dashboard datamanager")
        
//        getPreviews()
    }
    
    var delegate: DataManagerDelegate?
    var predicate: String?
    var moc: NSManagedObjectContext
    var thoughts = [Thought]()
    var busy = false
    
    required init(moc: NSManagedObjectContext) {
        self.moc = moc
        print("dm init'd")
    }
    
}
//
//extension DashboardDataManager: ThoughtDataEccessable {
//
//    func getPreviews() {
//        busy = true
//        // set empty predicate list
//        var predicates = [NSPredicate]()
//        let request = NSFetchRequest<Thought>(entityName: "Thought")
//        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
//        request.fetchBatchSize = 10
//        request.shouldRefreshRefetchedObjects = true
//        request.returnsObjectsAsFaults = false
//        request.sortDescriptors = [sortDescriptor]
//        if let pred = self.predicate {
//
//
//            // split search terms
//            let words = pred.lowercased().components(separatedBy: " ")
//
//            // create predicate for date, and title
//            // TODO: implement search for entries as well
//            for word in words {
//                let thoughtTitlePredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(Thought.title), word)
//                let thoughtDatePredicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(Thought.createdAt), word)
//                predicates.append(contentsOf: [thoughtTitlePredicate, thoughtDatePredicate])
//            }
//
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
//
//
//        }
//
//        searchForThoughts(request)
//
//    }
//
//    func refresh() {
//        getPreviews()
//    }
//
//    func searchForThoughts(_ request: NSFetchRequest<Thought>) {
//        do {
//            let thoughts = try moc.fetch(request)
//            previews = thoughts.toPreview()
//
//        } catch let err {
//            print(err)
//        }
//
//        busy = false
//    }
//}
//
