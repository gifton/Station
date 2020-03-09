
import UIKit

class ExploreView: UIScrollView {
    
    init(delegate: ExploreDelegate) {
        exploreDelegate = delegate
        super.init(frame: CGRect(x: 0, y: 0, width: Device.width, height: Device.height))
        self.delegate = self
        backgroundColor = .blue
        contentSize = .init(width, height * 2)
        backgroundColor = Styles.Colors.white
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        setTopView()
        setTable()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var topView: ExploreViewHeader!
	var table: UITableView!
    var exploreDelegate: ExploreDelegate
    var bottomView: ExploreViewFooter!
    private let haptic = UINotificationFeedbackGenerator()
    
}
private extension ExploreView {
    
	func setTopView() {
        
        topView = ExploreViewHeader()
        topView.delegate = self
        addSubview(topView)
        
	}
	
	func setTable() {
        
        bottomView = ExploreViewFooter()
        bottomView.delegate = exploreDelegate
        addSubview(bottomView)
        
    }
}

extension ExploreView: ExploreHeadDelegate {
    var thoughtCount: BasicStatInfo {
        return exploreDelegate.stats.filter {
            $0.statType == .thought
        }.first ?? BasicStatInfo(statType: .thought, weekCount: 0, monthCount: 0)
    }
    
    var recentThoughts: [ThoughtPreview] {
        return exploreDelegate.recentThoughts
    }
    
    func showInfo() { exploreDelegate.showInfoButton() }
    
    func showThought(atIndex index: Int) { exploreDelegate.showThought(atIndex: index) }
    
    func scrollToBottom() { setContentOffset(.init(0, contentSize.height / 2), animated: true) }
    
    var subThoughtCount: BasicStatInfo {
        return exploreDelegate.stats.filter {
            $0.statType == .subThought
        }.first ?? BasicStatInfo(statType: .thought, weekCount: 0, monthCount: 0)
    }
}
extension ExploreView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) { haptic.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success) }
}
