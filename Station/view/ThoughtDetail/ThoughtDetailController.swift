
import UIKit

class ThoughtDetailController: Controller {
    
    init(dm: ThoughtDetailDataManager, coordinator: ThoughtDetailCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.dataManager = dm
        self.coordinator = coordinator
        view.addSubview(ThoughtDetailView(withDelegate: self))
        view.backgroundColor = .white
        setHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var header = UIView(withColor: .white)
    var tv: UITableView!
    var createView: CreateSubThoughtView!
}


private extension ThoughtDetailController{
    
    func setView() {
        view.backgroundColor = .blue
        setHeader()
    }
    
    func setHeader() {
        
        header.frame.size = .init(Device.width, 80)
        let back = Icons.iv(withImageType: .arrow, size: .large)
        back.sizeToFit()
        back.frame.origin = .init(Styles.Padding.xLarge.rawValue)
        back.bottom = header.bottom.subtractPadding(.small)
        back.addTapGestureRecognizer(action: (coordinator as? ThoughtDetailCoordinator)?.navigateBack)
        
        let icon = Icons.iv(withImageType: .thought, size: .xLarge)
        icon.tintColor = .black
        icon.sizeToFit()
        icon.right = header.right.subtractPadding(.xLarge)
        icon.bottom = header.bottom.subtractPadding(.medium)
        
        header.addSubview(back)
        header.addSubview(icon)
        
        view.addSubview(header)
        
    }
    
    func refresh() {
        
    }
}

extension ThoughtDetailController: ThoughtDetailDelegate {
    func selectedOrbit(_ orbit: Orbit) {
        (coordinator as? ThoughtDetailCoordinator)?.showOrbit(orbit)
    }
    
    func setNewOrbit() {
        print("showing orbit from controller")
    }
    
    func newPhoto(completion: () -> ()) {
        if let c = (coordinator as? ThoughtDetailCoordinator) {
            c.createSubThought(ofType: .image) {
                completion()
            }
        }
        
    }
    
    func newLink(completion: () -> ()) {
        if let c = (coordinator as? ThoughtDetailCoordinator) {
            c.createSubThought(ofType: .link) {
                completion()
            }
        }
    }
    
    func newNote(completion: () -> ()) {
        if let c = (coordinator as? ThoughtDetailCoordinator) {
            c.createSubThought(ofType: .note) {
                completion()
            }
        }
    }
    
    var thought: ThoughtPreview {
        guard let dm = (dataManager as? ThoughtDetailDataManager) else {
            print("unable to access thought")
            return ThoughtPreview.zero
        }
        return dm.thought
    }
    
    
}
