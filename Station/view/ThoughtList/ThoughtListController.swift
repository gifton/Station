
import UIKit
import CoreLocation


class ThoughtListController: Controller {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = Styles.Colors.offWhite
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var tv: UITableView!
}


private extension ThoughtListController {
    func setView() {
        
        tv = UITableView(frame: view.frame, style: .insetGrouped)
        tv.register(cellWithClass: ThoughtPreviewCell.self)
        tv.registerHeaderFooter(cellWithClass: ThoughtTableHead.self)
        tv.delegate = self
        tv.dataSource = self
        
        view.addSubview(tv)
    }
}

extension ThoughtListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 90 }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 { return 150 }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let head = tableView.dequeueReusableHeader(cellWithClassName: ThoughtTableHead.self)
            head.delegate = self
            
            return head
        }
        else { return nil }
    }
}

extension ThoughtListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    func numberOfSections(in tableView: UITableView) -> Int {
        let out  = (dataManager as? ThoughtListDataManager)?.displayableThoughts.count  ?? 10
        
        return out
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ThoughtPreviewCell.self, for: indexPath)
        
        if let thought = (dataManager as? ThoughtListDataManager)?.displayableThoughts[indexPath.section] {
            cell.set(withThought: ThoughtPreview(thought: thought))
        }
        
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //  guard into header and searchbar, resign
        if let head = (scrollView as? UITableView)?.headerView(forSection: 0) as? ThoughtTableHead {
            head.searchBar.resignFirstResponder()
        }
    }
}

extension ThoughtListController: ThoughtTableHeadDelegate {
    
    func showInfo() {
        print("showing  info")
        (coordinator as? ThoughtsCoordinator)?.showInfoController()
    }
    
    func showSortOptions() {
        print("showing options")
    }
    
    func filter(withPredicate predicate: String) {
        (dataManager as? ThoughtListDataManager)?.filterThoughts(predicate)
        
        tv.reloadData { }
    }
    
    var numberOfThoughts: Int {
        get {
            return (dataManager as? ThoughtListDataManager)?.displayableThoughts.count ?? 0
        }
    }
    
}
