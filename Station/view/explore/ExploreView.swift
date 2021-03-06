
import UIKit

final class ExploreView: UIScrollView {
    
    init(delegate: ExploreDelegate) {
        exploreDelegate = delegate
        super.init(frame: CGRect(x: 0, y: 0, width: Device.width, height: Device.height - Device.tabBarheight))
        self.delegate = self
        backgroundColor = .blue
        contentSize = .init(width, ((Device.height - Device.tabBarheight) * 2))
        backgroundColor = Colors.hardBG
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        
        setContentOffset(.init(0, 50), animated: false)
        
        setTopView()
        setTable()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var topView: ExploreViewHeader!
	var table: UITableView!
    unowned var exploreDelegate: ExploreDelegate
    var bottomView: ExploreViewFooter!
    private let haptic = UINotificationFeedbackGenerator()
    
    public func viewNeedsRefresh() {
        
    }
    
}
private extension ExploreView {
    
	func setTopView() {
        
        topView = ExploreViewHeader(self)
        addSubview(topView)
        
	}
	
	func setTable() {
        
        bottomView = ExploreViewFooter()
        bottomView.delegate = exploreDelegate
        bottomView.frame.origin = .init(0,  topView.bottom)
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
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) { haptic.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success) }
}
