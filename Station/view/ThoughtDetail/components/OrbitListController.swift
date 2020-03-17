
import UIKit

protocol ThoughtDetailOrbitSelectorDelegate: AnyObject {
    var orbits: [Orbit] { get }
    func selectedOrbits(_ orbits: [Orbit])
}
class OrbitListController: Controller {
    init(delegate: ThoughtDetailOrbitSelectorDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var tv: UITableView!
    private weak var delegate: ThoughtDetailOrbitSelectorDelegate?
    
    private var selectedOrbits: [Orbit] = []
}

private extension OrbitListController {
    func setView() {
        let title = UILabel.title("Orbits", .max)
        title.sizeToFit()
        title.frame.origin = .init(Styles.Padding.xLarge.rawValue, 50)
        view.addSubview(title)
        
        tv = UITableView(frame: CGRect(x: 0, y: 100, width: view.width, height: view.height - 50), style: .insetGrouped)
        tv.register(cellWithClass: LongOrbitCell.self)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        view.addSubview(tv)
    }
}



extension OrbitListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension OrbitListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.orbits.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let del = delegate {
            let cell = tableView.dequeueReusableCell(withClass: LongOrbitCell.self, for: indexPath)
            cell.set(withOrbit: del.orbits[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let orbit = delegate?.orbits[indexPath.row] {
            selectedOrbits.append(orbit)
        }
    }
}
