
import CoreLocation

protocol OrbitDataAccessable: DataManager {
    func getOrbits() -> [Orbit]
    func createOrbit(withTitle title: String, andIcon: String)
    
}
