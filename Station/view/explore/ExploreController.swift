
import UIKit


class ExploreController: Controller {
    init() {
        super.init(nibName: nil, bundle: nil)
        view = ExploreView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
