
import UIKit

protocol ThoughtDisplayDelegate: AnyObject {
    
    var thoughts: [ThoughtPreview] { get }
    func selectedThought( atIndex index: Int)
    
}

final class ThoughtDisplay: UIView {
    
    init(point: CGPoint, title: Bool = true, delegate: ThoughtDisplayDelegate) {
        
        if title { self.title = UILabel.lightBody("Recent Thoughts") } else { self.title = nil}
        self.delegate = delegate
        super.init(frame: CGRect(origin: point, size: .init(Device.width, 190)))
        setView()
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private var direction: UICollectionView.ScrollDirection = .horizontal
    private var title: UILabel? = UILabel.title()
    private var isEmpty = true
    unowned var delegate: ThoughtDisplayDelegate {
        didSet {
            
            if delegate.thoughts.count == 0 { isEmpty = true }
            else { isEmpty = false }
            collection.reloadData()
        }
    }
    var collection: UICollectionView!
    var searchBar = UISearchBar()
    
    public func viewNeedsRefresh() {
        collection.reloadData()
    }

}

private extension ThoughtDisplay {
    
    func setView() {
        if let title = title {
            title.sizeToFit()
            title.frame.origin = .init(Styles.Padding.large.rawValue)
            addSubview(title)
        }
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction
        layout.itemSize = CGSize(275, 155)
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: Styles.Padding.large.rawValue, bottom: 0, right: 0)
        
        collection = UICollectionView(frame: CGRect(x: 0, y: title?.bottom.addPadding(.small) ?? 0, width: width, height: 155), collectionViewLayout: layout)
        collection.registerCell(ThoughtExtendedPreviewCell.self)
        collection.registerCell(EmptyCollectionCell.self)
        collection.backgroundView = .init(withColor: Colors.hardBG)
        collection.showsVerticalScrollIndicator = false
        collection.isScrollEnabled = true
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        
        addSubview(collection)
    }
    
}
extension ThoughtDisplay: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEmpty {
            return 1
        }
        return delegate.thoughts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isEmpty {
            return collectionView.dequeueReusableCell(withClass: EmptyCollectionCell.self, for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withClass: ThoughtExtendedPreviewCell.self, for: indexPath)
        cell.set(withThought: delegate.thoughts[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.selectedThought(atIndex: indexPath.row)
    }
}
