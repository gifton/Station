
import UIKit

class ThoughtDetailController: Controller {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var header = UIView(withColor: Styles.Colors.offWhite)
    var tv: UITableView!
    var createView: CreateSubThoughtView!
    override var coordinator: Coordinator? {
        didSet {
            setView()
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
        setCreateView()
        
    }
    
    func setCreateView() {
        createView = CreateSubThoughtView(withDelegate: self, point: .init(0, Device.height - Device.tabBarheight))
        view.addSubview(createView)
        setTable()
    }
    
    func setTable() {
        
        tv = UITableView()
        tv.frame =  CGRect(x: 0, y: header.bottom, width: Device.width, height: Device.height - (Device.tabBarheight + header.height))
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundView = .init(withColor: Styles.Colors.offWhite)
        tv.register(cellWithClass: ThoughtDetailOrbitCell.self)
        tv.registerHeaderFooter(cellWithClass: ThoughtDetailHead.self)
        
        view.addSubview(tv)
    }
}

extension ThoughtDetailController: UITableViewDelegate {
    
}

extension ThoughtDetailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = tableView.dequeueReusableHeader(cellWithClassName: ThoughtDetailHead.self)
        head.delegate = self
        
        return head
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 125
        }
        
        switch indexPath.row {
        case 0: return 125
        case 1: return 170
        default: return 140
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withClass: ThoughtDetailOrbitCell.self, for: indexPath)
            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
}

extension ThoughtDetailController: CreateSubThoughtDelegate {
    func newPhoto() {
        print("photo")
    }
    
    func newNote() {
        print("note")
    }
    
    func newLink() {
        print("link")
    }
}

extension  ThoughtDetailController: ThoughtDetailHeadDelegate {
    var thought: ThoughtPreview {
        return (dataManager as? ThoughtDetailDataManager)?.thought ?? .init(title: "Not available", location: nil)
    }
}

extension ThoughtDetailController: ThoughtDetailOrbitCellDelegate {
    func selectedOrbit(atIndex index: Int) {
        (coordinator as? ThoughtDetailCoordinator)?.showOrbit(orbits[index])
    }
    
    func joinNewOrbit() {
        print("show list of orbits lol")
    }
    
    var orbits: [Orbit] {
        return thought.orbits
    }
    
    
}
