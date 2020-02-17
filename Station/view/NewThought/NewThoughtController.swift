
import UIKit

class NewThoughtController: Controller {
    
    override func viewWillDisappear(_ animated: Bool) {
        print("view dissappearing")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ntView = NewThoughtView()
        ntView.thoughtDelegate = self
        
        view = ntView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        (view as? NewThoughtView)?.needsReset()
    }
}


extension NewThoughtController: NewThoughtViewDelegate {
    
    // showing new orbit
    func newOrbit() {
        
        // confirm coordinator is available casted properly
        if let coordinator = (coordinator as? NewThoughtCoordinator) {
            
            // call show orbit
            coordinator.showOrbit({ (title, icon) in
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
            return dm.orbits
        }
        return []
    }
    
    
}