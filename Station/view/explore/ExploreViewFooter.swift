
import UIKit

final class ExploreViewFooter: UIView {
    init() {
        super.init(frame: CGRect(origin: .zero, size: .init(Device.width, Device.height - (Device.tabBarheight / 2))))
        backgroundColor = Colors.softBG
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var tv: UITableView!
    weak var delegate: ExploreDelegate?{
        didSet{
            tv.reloadData()
        }
    }
    
    deinit {
        delegate = nil
    }
}


private extension ExploreViewFooter {
    func setView() {
        
        let title = UILabel.title("Orbits", .max)
        title.sizeToFit()
        title.frame.origin = .init(Styles.Padding.xLarge.rawValue, 50)
        addSubview(title)
        
        tv = UITableView(frame: CGRect(x: 0, y: 100, width: width, height: height - title.bottom), style: .insetGrouped)
        tv.register(cellWithClass: LongOrbitCell.self)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        addSubview(tv)
        
    }
}

extension ExploreViewFooter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension ExploreViewFooter: UITableViewDataSource {
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
    
}
