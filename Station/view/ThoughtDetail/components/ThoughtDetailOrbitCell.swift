
import UIKit

class ThoughtDetailOrbitCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundView = .init(withColor: Colors.offWhite)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: ThoughtDetailOrbitCellDelegate? {
        didSet {
            setView()
        }
    }
    
    var orbitSelector: OrbitSelector!
}

private extension ThoughtDetailOrbitCell {
    func setView() {
        let titleLabel = UILabel.labelWithImage("Orbits", image: Icons.iconForType(.orbit), location: .left)
        titleLabel.sizeToFit()
        titleLabel.left = 15
        titleLabel.top = 5
        addSubview(titleLabel)
        
        orbitSelector = OrbitSelector(point: .init(0, titleLabel.bottom.addPadding(.small)), title: nil, delegate: self, numberOfRows: 1, withSearch: false)
        addSubview(orbitSelector)
    }
    
    
}

extension ThoughtDetailOrbitCell: OrbitSelectorDelegate {
    func createNewOrbit() {
        delegate?.joinNewOrbit()
    }
    
    var orbits: [Orbit] {
        return delegate?.orbits ?? []
    }
    
    func filterOrbits(withPredicate predicate: String) { }
    
    func didSelectOrbit(atIndex index: Int) {
        delegate?.selectedOrbit(atIndex: index)
    }
    
    
}
