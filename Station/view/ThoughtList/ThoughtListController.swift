
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 100 }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 { return 150 }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return tableView.dequeueReusableHeader(cellWithClassName: ThoughtTableHead.self) }
        else { return nil }
    }
}

extension ThoughtListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    func numberOfSections(in tableView: UITableView) -> Int {
        var out  = (dataManager as? ThoughtListDataManager)?.displayableThoughts.count  ?? 10
        print("numbernof sectuibs: \(out)")
        return out
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ThoughtPreviewCell.self, for: indexPath)
        
        cell.set(withThought: ThoughtPreview(title: "This is my new thought right hurr!", location: CLLocation()))
        
        
        return cell
    }
}

extension ThoughtListController: ThoughtTableHeadDelegate {
    func showInfo() {
        print("showing  info")
    }
    
    func showSortOptions() {
        print("showing options")
    }
    
    func filter(withPredicate predicate: String) {
        (dataManager as? ThoughtListDataManager)?.filterThoughts(predicate)
    }
}
