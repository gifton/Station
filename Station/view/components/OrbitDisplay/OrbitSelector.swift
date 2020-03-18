
import UIKit

// orbit selector displays either half0width or full-width rows of Orbits
// user-definable attributes:
//      number of vertical lines
//      newButton type (circular, inline)
//      title label (insert label)

protocol OrbitSelectorDelegate: AnyObject {
    
    var orbits: [Orbit] { get }
    func filterOrbits(withPredicate predicate: String)
    func didSelectOrbit(atIndex index: Int)
}

// MARK: Orbit selecter class
final class OrbitSelector: UIView {
    
    init(point: CGPoint, title: String?, delegate: OrbitSelectorDelegate, numberOfRows: Int = 2, withSearch: Bool = true) {
    
        self.delegate = delegate
        collectionHeight = (CGFloat(50).addPadding(.medium)) * CGFloat(numberOfRows)
        isSearching = withSearch
        
        super.init(frame: CGRect(origin: point, size: CGSize(width: Device.width, height: collectionHeight + 95)))
        if let title = title {
            self.title?.text = title
        } else {
            self.title = nil
            setAvalibility(true)
        }
        
        setTitle()
        if withSearch { setSearch() }
        
        setCollection()
    }
    
    func setAvalibility(_ available: Bool = false) {
        
        if available {
            collection?.layer.opacity = 1.0
        } else {
            collection?.layer.opacity = 0.3
        }
        
    }
    
    var isSearching: Bool
    
    // call on npage reset, or new Object creation
    func needReset() {
        refresh()
        setAvalibility()
    }
    
    func refresh() {
        if let collection = collection {
            collection.reloadData()
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // private vars
    private var title: UILabel? = UILabel.body()
    private var collection: UICollectionView?
    private var collectionHeight: CGFloat = 0
    unowned private var delegate: OrbitSelectorDelegate
    private let searchbar = UISearchBar()
    
}

// private builder methods
private extension OrbitSelector {
    
    func setTitle() {
        if let title = title {
            
            title.sizeToFit()
            title.textColor = Colors.primaryText
            title.left = Styles.Padding.large.rawValue
            title.top = Styles.Padding.large.rawValue
            addSubview(title)
        }
        
    }
    
    func setSearch() {
        searchbar.frame = CGRect(origin: .init(Styles.Padding.xSmall.rawValue, title?.bottom.addPadding(.medium) ?? 0), size: .init(Device.width.subtractPadding(.medium, multiplier: 2), 45))
        searchbar.placeholder = "Search for an Orbit"
        searchbar.autocapitalizationType = .none
        searchbar.backgroundImage = UIImage()
        searchbar.barStyle = .default
        searchbar.returnKeyType = .done
        searchbar.showsCancelButton = true
        addSubview(searchbar)
    }
    
    func setCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
        
        if isSearching {
            collection = UICollectionView(frame: CGRect(x: 0, y: searchbar.bottom + Styles.Padding.medium.rawValue, width: width, height: collectionHeight), collectionViewLayout: layout)
        } else {
            collection = UICollectionView(frame: CGRect(x: 0, y:title?.bottom.addPadding(.medium) ?? 0, width: width, height: collectionHeight), collectionViewLayout: layout)
        }
        
        
        if let collection = collection {
            collection.backgroundView = .init(withColor: .clear)
            collection.backgroundColor  = .clear
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

extension OrbitSelector: UICollectionViewDelegateFlowLayout {}
// MARK: COllectionView DataSource / delegate conformance
extension OrbitSelector: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(175, 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return delegate.orbits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withClass: OrbitCell.self, for: indexPath)
        cell.set(withOrbit: delegate.orbits[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        (cell as? OrbitCell)?.didGetSelected()
        delegate.didSelectOrbit(atIndex: indexPath.row)
        
    }
    
    
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
