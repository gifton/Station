
import UIKit
import CoreLocation

// view that displaysall the thoughts available for user
// MARK: THoguhtListController
final class ThoughtListController: Controller {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = Colors.softBG
        setView()
    }
    
    override func controllerNeedsRefresh() {
        tv.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // refresh view on appear
    override func viewWillAppear(_ animated: Bool) {
        (dataManager as? ThoughtListDataManager)?.refresh()
        tv.reloadData()
    }
    
    // private vars
    private var isEmpty: Bool = true
    private var tv: UITableView!
    private var sortView: SortOptionListView?
    private var headController: ThoughtTableHeadController?
    // cover is shown when displaying sort options, indicate to user that content is unreachable during sort
    private var cover: UIView!
    var selectedOption: SortOption = .dateDescending
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
        tv.backgroundView = .init(withColor: Colors.hardBG)
        
        view.addSubview(tv)
        
        if let nums = (dataManager as? ThoughtListDataManager)?.displayableThoughts.count {
            if nums == 0 { setEmpty() }
        }
        
    }
    
    func setEmpty() {
        let v = UIView(frame: tv.frame)
        v.backgroundColor = .red
        tv.backgroundView = v
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
            headController = head
            return head
        }
        else {
            let view = UIView(frame: CGRect(origin: .init(0), size: CGSize(tableView.width, 5)))
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let thought = (dataManager as? ThoughtListDataManager)?.displayableThoughts[indexPath.section] {
            
            (coordinator as? ThoughtListCoordinator)?.showThought(thought)
            
        }
    }
    
}

extension ThoughtListController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    func numberOfSections(in tableView: UITableView) -> Int {
        if let out = (dataManager as? ThoughtListDataManager)?.displayableThoughts.count {
            if out == 0 { isEmpty = true; return 0 }
            else { return out }
        }
        
        return 10
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
                sv.frame.origin.y += sv.height + 50
            }
            sortView = nil
        }
    }
    
    func setSort(option: SortOption) {
        if let head = (tv.tableHeaderView as? ThoughtTableHead) { head.updateSortOption(option) }
    }
    
    
    func showSortOptions() {
        
        if let sv = sortView {
            
            self.cover = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialDark))
            self.cover.frame = self.view.bounds
            self.cover.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            self.view.addSubview(self.cover)
            self.cover.addTapGestureRecognizer {
                self.cover.removeFromSuperview()
                self.hideSortOptions()
            }
            
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.cover.alpha = 0.95
                self.view.addSubview(sv)
                sv.top -= 50
            }) { (_) in }
        } else { sortView = SortOptionListView(withDelegate: self); showSortOptions() }
    }
    
    
    func didSelect(option: SortOption) {
        
        selectedOption = option
        (dataManager as? ThoughtListDataManager)?.sort(by: option)
        tv.reloadData()
        headController?.updateSortOption(option)
        tv.reloadData()
        
        hideSortOptions()
        cover.removeFromSuperview()
        
    }
}
