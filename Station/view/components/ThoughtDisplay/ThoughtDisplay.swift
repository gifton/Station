
import UIKit

protocol ThoughtDisplayDelegate {
    
    var thoughts: [ThoughtPreview] { get }
    func selectedThought( atIndex index: Int)
    
}

class ThoughtDisplay: UIView {
    
    init(point: CGPoint, title: Bool = true, delegate: ThoughtDisplayDelegate) {
        if title {
            self.title = UILabel()
        }
        
        super.init(frame: Device.frame)
        setView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title = UILabel.titleLabel()
    var delegate: ThoughtDisplayDelegate?
    var collection: UICollectionView!
    var searchBar = UISearchBar()
    func setView() {
        
        title.sizeToFit()
        title.frame.origin = .init(Styles.Padding.large.rawValue)
        addSubview(title)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(Device.width - (Styles.Padding.medium.rawValue * 2), 155)
        
        collection = UICollectionView(frame: CGRect(x: 0, y: 55, width: width, height: Device.height - 150), collectionViewLayout: layout)
        collection.registerCell(ThoughtExtendedPreviewCell.self)
        collection.backgroundView = .init(withColor: Styles.Colors.offWhite)
        collection.showsVerticalScrollIndicator = false
        collection.isScrollEnabled = true
        collection.delegate = self
        collection.dataSource = self
        
        
        addSubview(collection)
    }
}

extension ThoughtDisplay: UICollectionViewDelegate { }
extension ThoughtDisplay: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ThoughtExtendedPreviewCell.self, for: indexPath)
        cell.set(withThought: ThoughtPreview(title: "This is giftons thought preview for testing", location: nil))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedThought(atIndex: indexPath.row)
    }
}
