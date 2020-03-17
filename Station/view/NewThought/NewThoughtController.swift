
import UIKit

class NewThoughtController: Controller {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ntView = NewThoughtView()
        ntView.thoughtDelegate = self
        
        view = ntView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        (dataManager as? NewThoughtDataManager)?.refresh()
        (view as? NewThoughtView)?.needsReset()
    }
}


extension NewThoughtController: NewThoughtViewDelegate {
    func save(withTitle title: String, andIcon icon: String) {
        if let dm = self.dataManager as? NewThoughtDataManager {
            dm.createOrbit(withTitle: title, andIcon: icon)
            (view as? NewThoughtView)?.needsReset()
        }
    }
    
    
    // showing new orbit
    func newOrbit() {
        
        // confirm coordinator is available casted properly
        if let coordinator = (coordinator as? NewThoughtCoordinator) {
            
            // call show orbit
            coordinator.newOrbit({ (title, icon) in
                print("orbit with title: \(title), and icon: \(icon) set in controller")
                
                // completion returns orbit title and icon
                // cast datamanger as proper type
                if let dm = self.dataManager as? NewThoughtDataManager {
                    
                    dm.createOrbit(withTitle: title, andIcon: icon)
                    (self.view as? NewThoughtView)?.needsReset()
                    
                }
                
            })
        }
        
    }
    
    func save(withTitle title: String, andOrbits orbits: [Orbit]) {
        if let dm = self.dataManager as? NewThoughtDataManager {
            dm.createThought(fromTitle: title, withLocation: nil, andOrbits: orbits)
        }
        
    }
    
    var orbits: [Orbit] {
        if let dm = self.dataManager as? NewThoughtDataManager {
            return dm.displayableOrbits
        }
        return []
    }
    
    func filterOrbits(withPredicate pred: String) {
        if let dm = self.dataManager as? NewThoughtDataManager {
            dm.filterOrbits(pred)
        }
    }
}
