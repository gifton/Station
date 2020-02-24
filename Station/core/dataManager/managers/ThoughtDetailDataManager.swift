
import CoreData

class ThoughtDetailDataManager: DataManager {
    var delegate: DataManagerDelegate?
    var moc: NSManagedObjectContext
    private var rawThought: Thought!
    
    required init(moc: NSManagedObjectContext) {
        self.moc = moc
        
    }
    
    convenience init(moc: NSManagedObjectContext, thought: Thought) {
        self.init(moc: moc)
        
        rawThought = thought
        self.thought = ThoughtPreview(thought: rawThought)
        
    }
    
    private var allSubThoughts: [SubThought] = []
    public var allOrbits: [Orbit] =  []
    public var thoughtOrbits: [Orbit] =  []
    public var thought: ThoughtPreview!
    
}

extension ThoughtDetailDataManager: SubThoughtDataAccessable {
    func createSubThought(ofType type: SubThoughtType, withPreview preview: SubThoughtPreview) {
        print("creating subTHought: \(type)")
    }
    
    func addThoughtToOrbit(_ orbit: Orbit) {
        print("adding orbit to thought")
    }
    
}


extension ThoughtDetailDataManager:  OrbitDataAccessable {
    func getOrbits() -> [Orbit] {
        let request = Orbit.sortedFetchRequest
        request.fetchBatchSize = 100
        request.shouldRefreshRefetchedObjects = true
        request.returnsObjectsAsFaults = false
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            return try moc.fetch(request)
            
        } catch { return [] }
    }
    
    func createOrbit(withTitle title: String, andIcon: String) {}
}
