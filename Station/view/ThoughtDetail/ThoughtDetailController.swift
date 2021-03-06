
import UIKit

class ThoughtDetailController: Controller {
    
    init(dm: ThoughtDetailDataManager, coordinator: ThoughtDetailCoordinator) {
        super.init(nibName: nil, bundle: nil)
        
        self.dataManager = dm
        self.coordinator = coordinator
        view.backgroundColor = .white
        setHeader()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(ThoughtDetailView(withDelegate: self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func controllerNeedsRefresh() {
        tv.reloadData()
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
        let back = Icons.iconView(withImageType: .arrow, size: .large)
        back.sizeToFit()
        back.frame.origin = .init(Styles.Padding.xLarge.rawValue)
        back.bottom = header.bottom.subtractPadding(.small)
        back.addTapGestureRecognizer(action: (coordinator as? ThoughtDetailCoordinator)?.navigateBack)
        
        let icon = Icons.iconView(withImageType: .thought, size: .xLarge)
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
                print("completed  photo")
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
            print("unable to access thought preview, returning empty thought")
            return ThoughtPreview.zero
        }
        return dm.thought
    }
    
    
}


extension ThoughtDetailController: ThoughtDetailOrbitSelectorDelegate {
    var orbits: [Orbit] {
        return []
    }
    
    func selectedOrbits(_ orbits: [Orbit]) {
        (dataManager as? ThoughtDetailDataManager)?.addThoughtToOrbit(orbits)
    }
    
}
