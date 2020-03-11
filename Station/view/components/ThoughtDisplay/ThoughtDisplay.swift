
import UIKit

protocol ThoughtDisplayDelegate {
    
    var thoughts: [ThoughtPreview] { get }
    func selectedThought( atIndex index: Int)
    
}

class ThoughtDisplay: UIView {
    
    init(point: CGPoint, title: Bool = true, delegate: ThoughtDisplayDelegate) {
        
        if title { self.title = UILabel.lightBody("Recent Thoughts") } else { self.title = nil}
        super.init(frame: CGRect(origin: point, size: .init(Device.width, 190)))
        setView()
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var direction: UICollectionView.ScrollDirection = .horizontal
    var title: UILabel? = UILabel.title()
    var delegate: ThoughtDisplayDelegate? {
        didSet {
            collection.reloadData()
        }
    }
    var collection: UICollectionView!
    var searchBar = UISearchBar()

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
        return delegate?.thoughts.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ThoughtExtendedPreviewCell.self, for: indexPath)
        if let del = delegate {
            cell.set(withThought: del.thoughts[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedThought(atIndex: indexPath.row)
    }
}
