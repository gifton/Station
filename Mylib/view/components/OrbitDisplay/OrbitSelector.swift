
import UIKit

// orbit selector displays either half0width or full-width rows of Orbits
// user-definable attributes:
//      number of vertical lines
//      newButton type (circular, inline)
//      title label (insert label)

protocol OrbitSelectorDelegate {
    
    func createNewOrbit()
    var orbits: [Orbit] { get }
    
}

class OrbitSelector: UIView {
    
    init(title: String, delegate: OrbitSelectorDelegate, numberOfRows: Int = 1) {
        self.title.text = title
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title = UILabel.titleLabel()
    var collection: UICollectionView!
    
    var orbits: [Orbit]
    var delegate: OrbitSelectorDelegate
}


private extension OrbitSelector {
    
    func setTitle() {
        title.sizeToFit()
        title.left = left + Styles.Padding.large.rawValue
        title.top = top + Styles.Padding.large.rawValue
        addSubview(title)
    }
    
    func setCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(175, 50)
        
        let collection = UICollectionView(frame: CGRect(x: Styles.Padding.small.rawValue, y: title.bottom + Styles.Padding.large.rawValue, width: width - (Styles.Padding.large.rawValue * 2), height: height - title.height - Styles.Padding.large.rawValue), collectionViewLayout: layout)
        
        collection.registerCell(OrbitCell.self)
        collection.registerCell(inlineNewOrbitCell.self)
        collection.registerCell(CircularNewOrbitCell.self)
        
        addSubview(collection)
    }
}


extension OrbitSelector: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

extension OrbitSelector: UICollectionViewDelegateFlowLayout {
    
}

extension OrbitSelector: UICollectionViewDelegate {
    
}
