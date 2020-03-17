
import UIKit

protocol MicroOrbitDelegate: AnyObject {
    var orbits: [Orbit] { get }
    func didSelectOrbit(_ orbit: Orbit)
    func addNewOrbit()
}

final class MicroOrbitView: UIView {
    init(withDelegate delegate: MicroOrbitDelegate, point: CGPoint) {
        self.delegate = delegate
        super.init(frame: CGRect(origin: point, size: .init(Device.width - (point.x * 2), 80)))
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cv: UICollectionView!
    unowned var delegate: MicroOrbitDelegate
}

private extension MicroOrbitView {
    func setView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(55, 75)
        
        cv = UICollectionView(frame: CGRect(origin: .zero, size: frame.size), collectionViewLayout: layout)
        cv.registerCell(CircularNewOrbitCell.self)
        cv.registerCell(MicroOrbitCell.self)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundView = .init(withColor: .white)
        
        addSubview(cv)
    }
}

// MARK: MicroOrbitView UICollectionView delegates and datasource conformance
extension MicroOrbitView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {  return delegate.orbits.count + 1 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            return collectionView.dequeueReusableCell(withClass: CircularNewOrbitCell.self, for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withClass: MicroOrbitCell.self, for: indexPath)
        
        cell.setWithIcon(delegate.orbits[indexPath.row - 1].icon, title: delegate.orbits[indexPath.row - 1].title)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 { delegate.addNewOrbit() }
        else {  delegate.didSelectOrbit(delegate.orbits[indexPath.row - 1]) }
    }
}

extension MicroOrbitView: UICollectionViewDelegate { }



class MicroOrbitCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundView = .init(withColor: Colors.hardBG)
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let lbl = UILabel.mediumTitle("✅", .xXLarge)
    let titleLabel = UILabel.body()
    func setWithIcon(_ icon: String, title: String) {
        lbl.text = icon
        lbl.frame = CGRect(x: 5, y: 5, width: 45, height: 45)
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = lbl.width / 2
        lbl.layer.borderColor = Colors.softBG.cgColor
        lbl.layer.borderWidth = 5
        addSubview(lbl)
        titleLabel.text = title
        titleLabel.frame = CGRect(x: 0, y: bounds.bottom - 17, width: bounds.width, height: 17)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
    }
    
    override func prepareForReuse() {
        lbl.text = ""
    }
}
