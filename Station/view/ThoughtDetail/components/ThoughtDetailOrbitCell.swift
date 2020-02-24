
import UIKit

class ThoughtDetailOrbitCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundView = .init(withColor: Styles.Colors.offWhite)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate: ThoughtDetailOrbitCellDelegate? {
        didSet {
            setView()
        }
    }
}

private extension ThoughtDetailOrbitCell {
    func setView() {
        let titleLabel = UILabel.labelWithImage("Orbits", image: Icons.iconForType(.orbit), location: .left)
        titleLabel.sizeToFit()
        titleLabel.left = 15
        titleLabel.top = 5
        addSubview(titleLabel)
        
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
