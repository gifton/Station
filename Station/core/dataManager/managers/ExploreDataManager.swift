
import UIKit
import CoreData
import CoreLocation
// MARK: Dashboard DM 
// accesses recently created thoughts, and all user-created orbits 
// creation methods present in object

final class ExploreDataManager: DataManager {
    
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
        thoughts = getThoughts(batchSize: 10)
        orbits = getAllOrbits(batchSize: 500)
        delegate?.dataIsSet()
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
        orbits = getAllOrbits(batchSize: 500)
    }
}

extension ExploreDataManager: ThoughtDataAccessable { }
extension ExploreDataManager: OrbitDataAccessable { }
