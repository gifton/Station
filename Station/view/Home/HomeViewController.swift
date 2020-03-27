

import UIKit

class HomeViewController: UIController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setMainViews()
    }
}

private extension HomeViewController {
    func setMainViews() {
        let tv = UITableView(frame: view.bounds)
        tv.backgroundView = .init(withColor: Colors.offWhite)
        tv.separatorStyle = .none
        tv.registerHeaderFooter(cellWithClass: HomeTableHeader.self)
        self.tableView = tv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { if section == 0 {return 275}; return 0 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = tableView.dequeueReusableHeader(cellWithClassName: HomeTableHeader.self)
        return head
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
        print("sliding to show topics")
    }
    
    func selectedColorChange(_ light: Bool) {
        print("changing to light:  \(light)")
    }
    
    
}
