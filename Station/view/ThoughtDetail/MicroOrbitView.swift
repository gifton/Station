
import UIKit

protocol MicroOrbitDelegate {
    var orbits: [Orbit] { get }
    func didSelectOrbit(_ orbit: Orbit)
    func addNewOrbit()
}

class MicroOrbitView: UIView {
    init(withDelegate delegate: MicroOrbitDelegate, point: CGPoint) {
        self.delegate = delegate
        super.init(frame: CGRect(origin: point, size: .init(Device.width - (point.x * 2), 50)))
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cv: UICollectionView!
    var delegate: MicroOrbitDelegate
}

private extension MicroOrbitView {
    func setView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(35)
        
        cv = UICollectionView(frame: CGRect(origin: .zero, size: frame.size), collectionViewLayout: layout)
        cv.registerCell(CircularNewOrbitCell.self)
        cv.registerCell(MicroOrbitCell.self)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundView = .init(withColor: .white)
        
        addSubview(cv)
    }
}


extension MicroOrbitView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {  return delegate.orbits.count + 1 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            return collectionView.dequeueReusableCell(withClass: CircularNewOrbitCell.self, for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withClass: MicroOrbitCell.self, for: indexPath)
        
        cell.setWithIcon(delegate.orbits[indexPath.row - 1].icon)
        
        return cell
    }
}

extension MicroOrbitView: UICollectionViewDelegate { }



class MicroOrbitCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundView = .init(withColor: Styles.Colors.offWhite)
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let lbl = UILabel.mediumTitle("✅", .xXLarge)
    
    func setWithIcon(_ icon: String) {
        lbl.text = icon
        lbl.frame = bounds
        lbl.textAlignment = .center
        addSubview(lbl)
    }
    
    override func prepareForReuse() {
        lbl.text = ""
    }
}
