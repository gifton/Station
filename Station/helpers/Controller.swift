

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
        reqLoc()
        return CLLocation()
    }
    func reqLoc() {
        
        var locationManager: CLLocationManager?
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
    }
}

extension Controller: CLLocationManagerDelegate {}


enum Failure {
    
    case toConnect
    case toRetrieveData(ofType: Any)
    case toDisplayData(ofType: Any)
    
}


