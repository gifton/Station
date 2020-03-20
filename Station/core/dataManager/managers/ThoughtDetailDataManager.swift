
import CoreData

// MARK: ThoughtDetail DM
// handles display of Single thought
// in charge of creation of new SubTHought declertions related to said Thought
 
final class ThoughtDetailDataManager: DataManager {
    weak var delegate: DataManagerDelegate?
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
    public var thought: ThoughtPreview!{
        didSet {
            delegate?.dataIsSet()
        }
    }
    
    func refresh() {
        let req = Thought.sortedFetchRequest
        req.predicate = NSPredicate(format: "self == %@", rawThought)
        let out = try! moc.fetch(req)
        
        print("refreshed dm")
        thought = ThoughtPreview(thought: out.first!)
    }
}

extension ThoughtDetailDataManager: SubThoughtDataAccessable {
    func createSubThought(withPreview preview: SubThoughtPreview) {
        
        preview.thought = rawThought
        _ = SubThought.insertFromPreview(into: moc, with: preview)
        if moc.saveOrRollback() {
            print("saved subthought with type: \(preview.type)")
            refresh()
        } else {
            print("couldnt save sb")
        }
        
    }
    
    func addThoughtToOrbit(_ orbits: [Orbit]) {
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
