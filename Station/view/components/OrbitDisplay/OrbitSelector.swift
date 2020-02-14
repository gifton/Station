
import UIKit

// orbit selector displays either half0width or full-width rows of Orbits
// user-definable attributes:
//      number of vertical lines
//      newButton type (circular, inline)
//      title label (insert label)

protocol OrbitSelectorDelegate {
    
    func createNewOrbit()
    var orbits: [Orbit] { get }
    
    func didSelectOrbit(atIndex index: Int)
}

class OrbitSelector: UIView {
    
    init(point: CGPoint, title: String, delegate: OrbitSelectorDelegate, numberOfRows: Int = 2) {
        self.title.text = title
        self.delegate = delegate
        collectionHeight = (50 + (Styles.Padding.medium.rawValue)) * CGFloat(numberOfRows)
        
        super.init(frame: CGRect(origin: point, size: CGSize(width: Device.width, height: collectionHeight + 55)))
        
        setTitle()
        setCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title = UILabel.bodyLabel()
    var collection: UICollectionView!
    var collectionHeight: CGFloat = 0
    
    var delegate: OrbitSelectorDelegate
    
}


private extension OrbitSelector {
    
    func setTitle() {
        title.sizeToFit()
        title.textColor = .black
        title.left = Styles.Padding.large.rawValue
        title.top = Styles.Padding.large.rawValue
        addSubview(title)
    }
    
    func setCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(175, 50)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: title.bottom + Styles.Padding.medium.rawValue, width: width, height: collectionHeight), collectionViewLayout: layout)
        collection.backgroundView = .init(withColor: .white)
        collection.registerCell(OrbitCell.self)
        collection.registerCell(inlineNewOrbitCell.self)
        collection.registerCell(CircularNewOrbitCell.self)
        collection.delegate = self
        collection.dataSource = self
        
        addSubview(collection)
    }
}


extension OrbitSelector: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(delegate.orbits.count)
        return delegate.orbits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            return collectionView.dequeueReusableCell(withClass: inlineNewOrbitCell.self, for: indexPath)
        } else {
            let cell = collectionView.dequeueReusableCell(withClass: OrbitCell.self, for: indexPath)
            cell.set(withOrbit: delegate.orbits[indexPath.row - 1])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelectOrbit(atIndex: indexPath.row - 1)
    }
    
}

extension OrbitSelector: UICollectionViewDelegateFlowLayout {
    
}

extension OrbitSelector: UICollectionViewDelegate {
    
}
