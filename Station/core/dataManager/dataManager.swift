
import CoreData
// MARK: DataManager protocol
// defines any object with conformance as able to access data
// any object that makes network or storage calls conforms to this protocol
// individual objects will have a protocol conforming that object to the methods required for access

protocol DataManagerDelegate {
    func data(isSet success: Bool)
    func data<T: DataPreview>() -> T
}


protocol DataManager: class {
    
    func start(completion: (() ->())? )
    var delegate: DataManagerDelegate? { get set }
    init(moc: NSManagedObjectContext)
}


