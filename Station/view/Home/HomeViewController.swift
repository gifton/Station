

import UIKit

class HomeViewController: UIController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setMainViews()
        setUpSliver()
    }
    
    private let sliver = TopicSliver(width: .small)
}

private extension HomeViewController {
    func setMainViews() {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        print(Device.width.subtractPadding(.small, multiplier: 2), 96)
        layout.estimatedItemSize = .init(view.width.subtractPadding(.xXLarge, multiplier: 2), 96)
        let cv = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        cv.registerReusableView(HomeTableHeader.self, kind: UICollectionView.elementKindSectionHeader)
        cv.backgroundView = .init(withColor: .white)
        collectionView = cv
        
    }
    
    func setUpSliver() {
        
        sliver.width = 100
        sliver.height = view.height
        sliver.frame.origin = .zero
        sliver.left -= sliver.width
        view.addSubview(sliver)
    }
}

extension HomeViewController: HomeHeadDelegate {
    func search(forPredicate predicate: String) {
        (viewModel as? ViewModelFilterDelegate)?.filter(withPredicate: predicate)
    }
    
    func showFilters() {
        print("showing filters")
    }
    
    func showTopics() {
        if sliver.left == 0 {
            hideSliver()
        } else {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.view.subviews.forEach {
                    $0.center.x += 100
                }
            }) { (_) in
                self.sliver.willDisplay()
            }
            
        }
    }
    
    func hideSliver() {
        sliver.endDisplay {
            UIView.animate(withDuration: 0.2) {
                self.view.subviews.forEach {
                    $0.center.x -= 100
                }
            }
        }
        
    }
    
    func selectedColorChange(_ light: Bool) {
        print("changing to light:  \(light)")
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(Device.width.subtractPadding(.small, multiplier: 2), 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(collectionView.width, 275)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let head = collectionView.dequeueReusableHeader(cellWithClass: HomeTableHeader.self, for: indexPath)
        head.setWithDelegate(self)
        return head
    }
}
