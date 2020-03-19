
import UIKit


final class ExploreController: Controller {
    
    override var dataManager: DataManager? {
        didSet {
            let exp = ExploreView(delegate: self)
            exp.frame = CGRect(x: 0, y: 0, width: Device.width, height: view.height - Device.tabBarheight)
            view = exp
        }
    }
    
    override func controllerNeedsRefresh() {
        (view as? ExploreView)?.viewNeedsRefresh()
    }
    
}

extension ExploreController: ExploreDelegate {
    var recentThoughts: [ThoughtPreview] {
        if let dm = (dataManager as? ExploreDataManager) {
            return dm.displayableThoughts
        }
        return []
    }
    
    var orbits: [Orbit] {
        if let dm = (dataManager as? ExploreDataManager) {
            return dm.orbits
        }
        return []
    }
    
    var stats: [BasicStatInfo] {
        if let dm = (dataManager as? ExploreDataManager) {
            return [dm.subThoughtStats, dm.thoughtStats]
        }
        return []
    }
    
    func showOrbit(atIndex index: Int) {
        print("selected index: \(index)")
        
        
    }
    
    func showThought(atIndex index: Int) {
        if let dm = (dataManager as? ExploreDataManager) {
            let thought = dm.thoughtForIndex(index)
            (coordinator as? ExploreCoordinator)?.showThought(thought)
        }
    }
    
    func showInfoButton() {
        (coordinator as? ExploreCoordinator)?.showInfoController()
    }
    
    
    
}
