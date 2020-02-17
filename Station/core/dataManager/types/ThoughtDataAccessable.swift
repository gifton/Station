
import CoreLocation

protocol ThoughtDataAccessable: DataManager {
    
    func getThoughts(withOrbitPredicate: Orbit?) -> [Thought]
    func createThought(fromTitle title: String, withLocation: CLLocation?, andOrbits orbits: [Orbit]?)
    
}
