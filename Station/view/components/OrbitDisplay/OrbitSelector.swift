
import UIKit

// orbit selector displays either half0width or full-width rows of Orbits
// user-definable attributes:
//      number of vertical lines
//      newButton type (circular, inline)
//      title label (insert label)

protocol OrbitSelectorDelegate {
    
    func createNewOrbit()
    var orbits: [Orbit] { get }
    func filterOrbits(withPredicate predicate: String)
    func didSelectOrbit(atIndex index: Int)
}

class OrbitSelector: UIView {
    
    init(point: CGPoint, title: String, delegate: OrbitSelectorDelegate, numberOfRows: Int = 2) {
        self.title.text = title
        self.delegate = delegate
        collectionHeight = (50 + (Styles.Padding.medium.rawValue)) * CGFloat(numberOfRows)
        
        super.init(frame: CGRect(origin: point, size: CGSize(width: Device.width, height: collectionHeight + 95)))
        
        setTitle()
        setSearch()
        setCollection()
        setAvalibility()
    }
    
    func setAvalibility(_ available: Bool = false) {
        
        if available {
            layer.opacity = 1.0
        } else {
            layer.opacity = 0.4
        }
        
    }
    
    func needReset() {
        if let collection = collection {
            collection.reloadData()
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private var title = UILabel.bodyLabel()
    private var collection: UICollectionView?
    private var collectionHeight: CGFloat = 0
    private var delegate: OrbitSelectorDelegate
    private let searchbar = UISearchBar()
    
}


private extension OrbitSelector {
    
    func setTitle() {
        title.sizeToFit()
        title.textColor = .black
        title.left = Styles.Padding.large.rawValue
        title.top = Styles.Padding.large.rawValue
        addSubview(title)
    }
    
    func setSearch() {
        searchbar.frame = CGRect(origin: .init(Styles.Padding.xSmall.rawValue, title.bottom + Styles.Padding.medium.rawValue), size: .init(Device.width - (Styles.Padding.medium.rawValue * 2), 45))
        searchbar.placeholder = "Search for an Orbit"
        searchbar.autocapitalizationType = .none
        searchbar.backgroundImage = UIImage()
        searchbar.barStyle = .default
        searchbar.delegate = self
        searchbar.returnKeyType = .done
        searchbar.showsCancelButton = true
        addSubview(searchbar)
    }
    
    func setCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(175, 50)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
        
        collection = UICollectionView(frame: CGRect(x: 0, y: searchbar.bottom + Styles.Padding.medium.rawValue, width: width, height: collectionHeight), collectionViewLayout: layout)
        
        if let collection = collection {
            collection.backgroundView = .init(withColor: .white)
            collection.showsHorizontalScrollIndicator = false
            collection.registerCell(OrbitCell.self)
            collection.registerCell(inlineNewOrbitCell.self)
            collection.registerCell(CircularNewOrbitCell.self)
            collection.delegate = self
            collection.dataSource = self
            
            addSubview(collection)
        }
        
    }
}


extension OrbitSelector: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(delegate.orbits.count)
        return delegate.orbits.count  + 1
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
        
        if indexPath.row == 0 {
            
            delegate.createNewOrbit()
            
        } else {
            
            let cell = collectionView.cellForItem(at: indexPath)
            (cell as? OrbitCell)?.didGetSelected()
            delegate.didSelectOrbit(atIndex: indexPath.row - 1)
            
        }
    }
    
    
}

extension OrbitSelector: UICollectionViewDelegateFlowLayout {
    
}

extension OrbitSelector: UICollectionViewDelegate {
    
}

extension OrbitSelector: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate.filterOrbits(withPredicate: searchText)
        needReset()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate.filterOrbits(withPredicate: "")
        self.searchbar.resignFirstResponder()
        needReset()
    }
}
