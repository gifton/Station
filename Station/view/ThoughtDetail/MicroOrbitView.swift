
import UIKit

protocol MicroOrbitDelegate {
    var orbits: [Orbit] { get }
    func didSelectOrbit(_ orbit: Orbit)
    func addNewOrbit()
}

class MicroOrbitView: UIView {
    init(withDelegate delegate: MicroOrbitDelegate, point: CGPoint) {
        self.delegate = delegate
        super.init(frame: CGRect(origin: point, size: .init(Device.width, 36)))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate: MicroOrbitDelegate
}

private extension MicroOrbitView {
    func setView() {
        
    }
}


extension MicroOrbitView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate.orbits.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            
        }
        let cell = collectionView.dequeueReusableCell(withClass: MicroOrbitCell.self, for: indexPath)
        cell.setWithIcon(delegate.orbits[indexPath.row - 1].icon)
        
        return cell
    }
}

extension MicroOrbitView: UICollectionViewDelegate {
    
}



class MicroOrbitCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWithIcon(_ icon: String) {
        let lbl = UILabel.mediumTitleLabel("", .xXLarge)
        lbl.set(textWithShadow: icon, lightShadow: false)
        lbl.frame = frame
        lbl.textAlignment = .center
        addSubview(lbl)
    }
}
