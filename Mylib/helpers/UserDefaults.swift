
import Foundation

// user defaults handles variable information for saving info to core data
// as well as authentication and authorization for hardware


// thought, entry, and trait creation requires objects to have unique ID's
// mark creation of new object with calling createdNew func, then retrieving the new IDs


extension UserDefaults {
    
    enum Keys {
        static let thoughtID     = "ThoughtID"
        static let name          = "USERname"
        static let email         = "USERemail"
        static let authenticated = "USERauthenticate"
        static let cameraAuth    = "CAMERAAUTHORIZATION"
        static let orbitID       = "orbitID"
    }
    
    private enum Prefix: String {
        case thought = "STNt-"
        case subThought = "STNst-"
        case orbit = "STNo-"
    }
    
    
    // creator methods
    static func createdNewThought() -> String {
        let defaults = UserDefaults.standard
        let defaultCount = defaults.integer(forKey: UserDefaults.Keys.thoughtID)
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.thoughtID)
        
        return Prefix.thought.rawValue + String(describing: UserDefaults.standard.integer(forKey: UserDefaults.Keys.thoughtID))
    }
    
    static func creatednewOrbit() -> String {
        let defaults = UserDefaults.standard
        let defaultCount = defaults.integer(forKey: UserDefaults.Keys.orbitID)
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.orbitID)
        
        return Prefix.orbit.rawValue + String(describing: UserDefaults.standard.integer(forKey: UserDefaults.Keys.orbitID))
    }
    
    static func createdNewSubThought(forThoughtID id: String) -> String {
        let defaults = UserDefaults.standard
        let defaultCount = defaults.integer(forKey: UserDefaults.Keys.orbitID)
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.orbitID)
        
        return id + String(describing: UserDefaults.standard.integer(forKey: UserDefaults.Keys.orbitID))
    }
}
