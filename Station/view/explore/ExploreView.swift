
import UIKit

class ExploreView: UIScrollView {
    init() {
        super.init(frame: Device.frame)
        backgroundColor = .blue
        contentSize = .init(Device.width, height * 2)
        backgroundColor =  .white
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        setTopView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var topView: ExploreViewHeader!
	var table: UITableView!
	
}
private extension ExploreView {
	func setTopView() {
        topView = ExploreViewHeader()
        addSubview(topView)
        
        
	}
	
	func setTable() {  }
}
