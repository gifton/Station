
import UIKit

final class NewThoughtController: Controller {
    
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
    
    override func controllerNeedsRefresh() {
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
