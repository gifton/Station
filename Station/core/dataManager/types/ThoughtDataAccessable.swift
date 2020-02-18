
import CoreLocation

protocol ThoughtDataAccessable: DataManager {
    
    func getThoughts() -> [Thought]
    func createThought(fromTitle title: String, withLocation: CLLocation?, andOrbits orbits: [Orbit]?)
    
}
