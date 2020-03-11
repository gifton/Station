
import UIKit


class ExploreController: Controller {
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = Colors.hardBG
        view.addSubview(ExploreView(delegate: self))
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
        print("selected index: \(index)")
    }
    
    func showInfoButton() {
        (coordinator as? ExploreCoordinator)?.showInfoController()
    }
    
    
    
}
