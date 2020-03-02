
import Foundation

// user defaults handles variable information for saving info to core data
// as well as authentication and authorization for hardware
// TODO: -- Implement property wrapper version of UD 
// thought, entry, and trait creation requires objects to have unique ID's
// mark creation of new object with calling createdNew func, then retrieving the new IDs
// MARK: Userdaultshelper extensions
extension UserDefaults {
    
    // all data types defined
    enum Keys {
        static let thoughtID     = "ThoughtID"
        static let name          = "USERname"
        static let email         = "USERemail"
        static let authenticated = "USERauthenticate"
        static let cameraAuth    = "CAMERAAUTHORIZATION"
        static let orbitID       = "orbitID"
        static let locationAuth  = "LOCATIONAUTHORIZATION"
    }
    
    // saving ID's hae prefixes identifying datatype
    private enum Prefix: String {
        case thought = "STNt-"
        case subThought = "STNst-"
        case orbit = "STNo-"
    }
    
    
    // creator methods
    // Thought
    static func createdNewThought() -> String {
        let defaults = UserDefaults.standard
        let defaultCount = defaults.integer(forKey: UserDefaults.Keys.thoughtID)
        
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.thoughtID)
        
        return Prefix.thought.rawValue + String(describing: UserDefaults.standard.integer(forKey: UserDefaults.Keys.thoughtID))
    }
    
    // Orbit
    static func creatednewOrbit() -> String {
        let defaults = UserDefaults.standard
        let defaultCount = defaults.integer(forKey: UserDefaults.Keys.orbitID)
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.orbitID)
        
        return Prefix.orbit.rawValue + String(describing: UserDefaults.standard.integer(forKey: UserDefaults.Keys.orbitID))
    }
    
    // SubThought
    static func createdNewSubThought(forThoughtID id: String) -> String {
        let defaults = UserDefaults.standard
        let defaultCount = defaults.integer(forKey: UserDefaults.Keys.orbitID)
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.orbitID)
        
        return Prefix.subThought.rawValue + id + String(describing: UserDefaults.standard.integer(forKey: UserDefaults.Keys.orbitID))
    }
    
    // location data
    static var isLocationAvailable: Bool {
        get { return UserDefaults.standard.bool(forKey: UserDefaults.Keys.locationAuth) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaults.Keys.locationAuth)}
    }
}
