
import CoreData
import CoreLocation

// MARK: DataManager protocol
// defines any object with conformance as able to access data
// any object that makes network or storage calls conforms to this protocol
// individual objects will have a protocol conforming that object to the methods required for access

protocol DataManagerDelegate: Controller {
    func data(isSet success: Bool)
    func data<T: DataPreview>() -> T
    func requestLocation() -> CLLocation?
}


protocol DataManager: AnyObject {
    
//    func start(completion: (() ->())? )
    func refresh()
    var delegate: DataManagerDelegate? { get set }
    var moc: NSManagedObjectContext { get }
    init(moc: NSManagedObjectContext)
}



