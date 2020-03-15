
import UIKit


class ExploreController: Controller {
    init() {
        super.init(nibName: nil, bundle: nil)
        let exp = ExploreView(delegate: self)
        exp.frame = CGRect(x: 0, y: 0, width: Device.width, height: Device.height - Device.tabBarheight)
        view = exp
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var dm: ExploreDataManager? {
        return (dataManager as? ExploreDataManager)
    }
    
}

extension ExploreController: ExploreDelegate {
    var recentThoughts: [ThoughtPreview] {
        if let dm = dm {
            return dm.displayableThoughts
        }
        return []
    }
    
    var orbits: [Orbit] {
        if let dm = dm {
            return dm.orbits
        }
        return []
    }
    
    var stats: [BasicStatInfo] {
        if let dm = dm {
            return [dm.subThoughtStats, dm.thoughtStats]
        }
        return []
    }
    
    func showOrbit(atIndex index: Int) {
        print("selected index: \(index)")
        
        
    }
    
    func showThought(atIndex index: Int) {
        
        if let thought = dm?.thoughtForIndex(index) {
            
            (coordinator as? ExploreCoordinator)?.showThought(thought)
        }
    }
    
    func showInfoButton() {
        (coordinator as? ExploreCoordinator)?.showInfoController()
    }
    
    
    
}
