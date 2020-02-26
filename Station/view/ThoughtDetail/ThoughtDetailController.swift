
import UIKit

class ThoughtDetailController: Controller {
    init() {
        super.init(nibName: nil, bundle: nil)
        view.addSubview(ThoughtDetailView(withDelegate: self))
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var header = UIView(withColor: .white)
    var tv: UITableView!
    var createView: CreateSubThoughtView!
    override var coordinator: Coordinator? {
            didSet {
                setHeader()
            }
        }
}


private extension ThoughtDetailController{
    
    func setView() {
        view.backgroundColor = .blue
        setHeader()
    }
    
    func setHeader() {
        
        header.frame.size = .init(Device.width, 80)
        let back = Icons.iv(withImageType: .arrow, size: .init(35))
        back.sizeToFit()
        back.frame.origin = .init(Styles.Padding.xLarge.rawValue)
        back.bottom = header.bottom.subtractPadding(.small)
        back.addTapGestureRecognizer(action: (coordinator as? ThoughtDetailCoordinator)?.navigateBack)
        
        let icon = Icons.iv(withImageType: .thought, size: .init(40))
        icon.tintColor = .black
        icon.sizeToFit()
        icon.right = header.right.subtractPadding(.xLarge)
        icon.bottom = header.bottom.subtractPadding(.medium)
        
        header.addSubview(back)
        header.addSubview(icon)
        
        view.addSubview(header)
        
        
        
        func refresh() {
            
        }
    }
}

extension ThoughtDetailController: ThoughtDetailDelegate {
    func newPhoto() {
        if let c = (coordinator as? ThoughtDetailCoordinator), let dm  =  (dataManager as? ThoughtDetailDataManager) {
            c.createSubThought(ofType: .image) {
                print("new note")
            }
        }
        
    }
    
    func newLink() {
        if let c = (coordinator as? ThoughtDetailCoordinator), let dm  =  (dataManager as? ThoughtDetailDataManager) {
            c.createSubThought(ofType: .link) {
                print("new note")
            }
        }
    }
    
    func newNote() {
        if let c = (coordinator as? ThoughtDetailCoordinator), let dm  =  (dataManager as? ThoughtDetailDataManager) {
            c.createSubThought(ofType: .note) {
                print("new note")
            }
        }
    }
    
    var thought: ThoughtPreview {
        (dataManager as? ThoughtDetailDataManager)?.thought ?? ThoughtPreview.zero
    }
    
    
}
