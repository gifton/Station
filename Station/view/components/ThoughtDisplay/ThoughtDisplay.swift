
import UIKit

protocol ThoughtDisplayDelegate {
    var thoughts: [ThoughtPreview] { get }
}

class ThoughtDisplay: UIView {
    init(point: CGPoint, title: Bool = true, delegate: ThoughtDisplayDelegate) {
        super.init(frame: CGRect(origin: point, size: .init(Device.width, 155 + Styles.Padding.small.rawValue + (title ? 25 : 0 ))))
        setView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: UILabel?
    var delegate: ThoughtDisplayDelegate?
    var collection: UICollectionView!
    
    func setView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(275, 155)
        
        collection = UICollectionView(frame: CGRect(x: 0, y: (title?.bottom ?? 0) + Styles.Padding.medium.rawValue, width: width, height: 155), collectionViewLayout: layout)
        collection.backgroundView = .init(withColor: Styles.Colors.offWhite)
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        
        collection.registerCell(ThoughtExtendedPreviewCell.self)
        
        addSubview(collection)
    }
}

extension ThoughtDisplay: UICollectionViewDelegate { }
extension ThoughtDisplay: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ThoughtExtendedPreviewCell.self, for: indexPath)
        cell.set(withThought: ThoughtPreview(title: "This is giftons thought preview for testing", location: nil))
        return cell
    }
    
    func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        guard let collectionView = self.collection else {
            return collection.contentOffset
        }

        // Page width used for estimating and calculating paging.
        let pageWidth: CGFloat = 250

        // Make an estimation of the current page position.
        let approximatePage = collectionView.contentOffset.x / pageWidth

        // Determine the current page based on velocity.
        let currentPage = velocity.x == 0 ? round(approximatePage) : (velocity.x < 0.0 ? floor(approximatePage) : ceil(approximatePage))

        // Create custom flickVelocity.
        let flickVelocity = velocity.x * 0.3

        // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)

        // Calculate newHorizontalOffset.
        let newHorizontalOffset = ((currentPage + flickedPages) * pageWidth) - collectionView.contentInset.left

        return CGPoint(x: newHorizontalOffset, y: proposedContentOffset.y)
    }
}
