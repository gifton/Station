
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
        
        
    }
}

extension ThoughtDetailController: ThoughtDetailDelegate {
    func newPhoto() {
        print("showing sub thought photo creator")
    }
    
    func newLink() {
        print("showing sub thought link creator")
    }
    
    func newNote() {
        print("showing sub thought note creator")
    }
    
    var thought: ThoughtPreview {
        (dataManager as? ThoughtDetailDataManager)?.thought ?? ThoughtPreview.zero
    }
    
    
}
