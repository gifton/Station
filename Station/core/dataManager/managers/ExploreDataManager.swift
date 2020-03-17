
import UIKit
import CoreData
import CoreLocation
// MARK: Dashboard DM 
// accesses recently created thoughts, and all user-created orbits 
// creation methods present in object

final class ExploreDataManager: DataManager {
    
    func start(completion: (() -> ())?) {
        
        thoughts = getThoughts(batchSize: 10)
        orbits = getOrbits(batchSize: 500)
        completion?()
    }
    
    weak internal var delegate: DataManagerDelegate?
    private var predicate: String?
    internal var moc: NSManagedObjectContext
    private var thoughts = [Thought]()
    public var orbits: [Orbit] = []
    public var displayableThoughts: [ThoughtPreview] {
        return thoughts.toPreview()
    }
    
    required init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func thoughtForIndex(_  index: Int) -> Thought {
        return thoughts[index]
    }
    
    var subThoughtStats: BasicStatInfo {
        return BasicStatInfo(statType: .subThought, weekCount: 25, monthCount: 130)
        
    }
    
    var thoughtStats: BasicStatInfo {
        return BasicStatInfo(statType: .thought, weekCount: 6, monthCount: 22)
    }
    
    func refresh() {
        thoughts = []
        thoughts = getThoughts(batchSize: 10)
        
        orbits = []
        orbits = getOrbits(batchSize: 500)
    }
}

extension ExploreDataManager: ThoughtDataAccessable { }
extension ExploreDataManager: OrbitDataAccessable { }
