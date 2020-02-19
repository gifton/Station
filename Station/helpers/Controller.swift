

import UIKit
import CoreLocation

// custom viewController wrapper
// added functinoality for all viewControllers
// controller has standard objects for collectionviews, tableViews, scrollViews, and datamanagers
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
                print("data manager set in controller")
                dm.delegate = self
            }
        }
    }
    
    var coordinator: Coordinator?
    
    // deinit method
    func controllerWillDeInit() {
        dataManager = nil
        
        print("controller deinit'd:", self)
        
    }
    
    deinit {
        controllerWillDeInit()
    }
    
    // faliure
    func faluire(to failure: Failure) {
        switch failure {
        case .toConnect: print("failure to connect to servers")
        default: print("failure: \(failure)")
        }
    }
    
}

extension Controller: DataManagerDelegate {
    func data<T>() -> T where T : DataPreview {
        return ThoughtPreview.zero as! T
    }
    
    
    func data(isSet success: Bool) {
        
        if success {
            
            print("data for controller: \(self) is set")
            
            
        } else {
            
            showMessage(title: "unable to prossess data", message: "ok")
            
        }
        
    }
    
    func requestLocation() -> CLLocation? {
        
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
    private func reqLoc(completion: () -> ()) {
        
        var locationManager: CLLocationManager?
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
    }
}

extension Controller: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse: UserDefaults.isLocationAvailable = true
        default: UserDefaults.isLocationAvailable = false
        }
        
        print("set location status",  status.rawValue)
    }
}


enum Failure {
    
    case toConnect
    case toRetrieveData(ofType: Any)
    case toDisplayData(ofType: Any)
    
}


