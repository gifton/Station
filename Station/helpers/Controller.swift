

import UIKit
import CoreLocation

// custom viewController wrapper
// added functinoality for all viewControllers
// controller has standard optional objects for dataManagers and coordinators
// standard deinit code
class Controller: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Styles.Colors.offWhite
    }
    
    // MARK: - Message Error
    func showMessage(title: String, message: String, handler: ((_ action: UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
    
    
    // data manager
    var dataManager: DataManager? {
        didSet(manager) {
            if let dm = manager {
                dm.delegate = self
            }
        }
    }

    
    private var dataIsSet: Bool = false
    var coordinator: Coordinator?
    
    // deinit method
    func controllerWillDeInit() {
        dataManager = nil
        coordinator = nil        
    }
    
    deinit {
        controllerWillDeInit()
    }
    
    // faliure
    private func faluire(to failure: Failure) {
        switch failure {
        case .toConnect: print("failure to connect to servers")
        default: print("failure: \(failure)")
        }
    }
    
}


// MARK: COntroller DataManagerDelegate conformance
extension Controller: DataManagerDelegate {
    func data<T>() -> T where T: DataPreview {
        return ThoughtPreview.zero as! T
    }
    
    
    func data(isSet success: Bool) {
        
        if success {
            dataIsSet = true 
        } else {
            showMessage(title: "unable to prossess data", message: "refresh")   
        }
        
    }
    
    // public facin location requestin method
    func requestLocation() -> CLLocation? {
        
        // check to see if location data is readily available
        if UserDefaults.isLocationAvailable {
            print("user  is set wiith location")
            return CLLocation()
        }
        print("user  is not set wiith location")
        
        var loc: CLLocation?
        reqLoc {
            loc = CLLocation()
        }
        return loc
        
    }

    // request location permissions
    private func reqLoc(completion: () -> ()) {
        
        var locationManager: CLLocationManager?
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
    }
}

// location permissions delegated to Controller
//MARKL Controller LocationManager ddelegate conformance
extension Controller: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse: UserDefaults.isLocationAvailable = true
        default: UserDefaults.isLocationAvailable = false
        }
        
        print("set location status",  status.rawValue)
    }
}


// faluire based on UI/network/db retrieval enum
enum Failure {
    
    case toConnect
    case toRetrieveData(ofType: Any)
    case toDisplayData(ofType: Any)
    
}


