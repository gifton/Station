
import UIKit
import CoreLocation

protocol LocationDataAccessable: DataManager {
    
    var locationDataIsAvailable: Bool { get }
    func requestAuthorization() -> CLLocation?
    
}
