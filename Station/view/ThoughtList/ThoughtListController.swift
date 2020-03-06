
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
    
    override func viewWillAppear(_ animated: Bool) {
        (dataManager as? ThoughtListDataManager)?.refresh()
        tv.reloadData()
    }
    
    private var tv: UITableView!
    private var sortView: SortOptionListView?
    var cover: UIView!
    var selectedOption: SortOption = .dateDescending {
        didSet (newVal) {
            (dataManager as? ThoughtListDataManager)?.sort(by: newVal)
            tv.reloadData()
        }
    }
}


private extension ThoughtListController {
    func setView() {
        
        tv = UITableView(frame: view.frame, style: .insetGrouped)
        tv.register(cellWithClass: ThoughtPreviewCell.self)
        tv.registerHeaderFooter(cellWithClass: ThoughtTableHead.self)
        tv.delegate = self
        tv.dataSource = self
        tv.sectionHeaderHeight = 0
        tv.sectionFooterHeight = 5
        tv.backgroundView = .init(withColor: .white)
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
        else {
            let view = UIView(frame: CGRect(origin: .init(0), size: CGSize(tableView.width, 5)))
            view.backgroundColor = .red
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let thought = (dataManager as? ThoughtListDataManager)?.displayableThoughts[indexPath.section] {
            
            print(thought.title + "has been selected")
            (coordinator as? ThoughtListCoordinator)?.showThought(thought)
            
        }
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
        (coordinator as? ThoughtListCoordinator)?.showInfoController()
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


extension ThoughtListController: SortOptionsListDelegate  {
    
    func hideSortOptions() {
        if let sv = sortView {
            UIView.animate(withDuration: 0.25) {
                sv.frame.origin.y += sv.height
            }
            sortView = nil
        }
    }
    
    
    func showSortOptions() {
        
        if let sv = sortView {
            sv.frame.origin = .init(0, view.bottom)
            view.insertSubview(sv, at: 1000)
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                sv.frame.origin.y -= sv.height
            }) { (_) in
                self.cover = UIView(withColor: UIColor.black.withAlphaComponent(0.65))
                self.cover.frame.size = .init(Device.width, self.view.height - sv.height)
                self.view.addSubview(self.cover)
                self.cover.addTapGestureRecognizer {
                    self.cover.removeFromSuperview()
                    self.hideSortOptions()
                }
            }
        } else { sortView = SortOptionListView(withDelegate: self); showSortOptions() }
    }
    
    
    func didSelect(option: SortOption) {
        
        selectedOption = option
        hideSortOptions()
        
        cover.removeFromSuperview()
        
    }
}
