

import UIKit

open class UIController: UIViewController {
    
    // data manager
    var viewModel: ViewModel
    var tableView: UITableView? { didSet { setTableView() } }
    internal  var previewType: PreviewType
    private var dataIsSet: Bool = false
    private var dimmer: UIVisualEffectView?
    
    init(model: ViewModel, type: PreviewType) {
        self.previewType = type
        viewModel = model
        super.init(nibName: nil, bundle: nil)        
    }
    
    
    required public init?(coder: NSCoder) {  fatalError("init(coder:) has not been implemented") }
    
    deinit {
        print("deiniting controller")
        dimmer =  nil
    }
}

public extension UIController {
    
    func dim(behindView focusedView: UIView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        dimmer = UIVisualEffectView(effect: blurEffect)
        
        if let dimmer = dimmer  {
            dimmer.frame = view.bounds
            dimmer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(dimmer)
        }
    
        view.addSubview(focusedView)
        
    }
    
    func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeChildController(_ child: UIViewController, toContainerView containerView: UIView) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    func setTableView() {
        if let tv = tableView {
            tv.delegate = self
            tv.dataSource = self
            // register classes
            view.addSubview(tv)
        }
    }
    
}

extension UIController: UITableViewDelegate {}

extension UIController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !dataIsSet {
            
            let cell = UITableViewCell()
            cell.backgroundView = .init(withColor: Colors.primaryBlue)
            return cell
        }
        
        guard let vm = (viewModel as? ViewModelTableDataSource),
            let preview = vm.loadedPreview(forIndex: indexPath.row)
            else { return UITableViewCell() }
        
        switch preview.previewType {
        case .link:  return UITableViewCell()
        case .note: return UITableViewCell()
        case .image: return UITableViewCell()
        case .thought: return UITableViewCell()
        case .topic: return UITableViewCell()
        }
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if !dataIsSet { return 200 }
        else {
            guard let vm = (viewModel as? ViewModelTableDataSource),
                let preview = vm.loadedPreview(forIndex: indexPath.row)
                else { return 175 }
            
            switch preview.previewType {
            case .thought: return 96
            case .topic: return 110
            default: return (preview as? SubThoughtPreview)?.contentHeight ?? 100
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !dataIsSet {
            return 1
        } else {
            guard let vm = (viewModel as? ViewModelTableDataSource) else { return 1 }
            return vm.count
        }
    }
}

extension UIController: ViewModelDelegate {
    
    func dataRecieved() {
        print("data is recieved")
        dataIsSet = true
        tableView?.reloadData()
    }
    
    
}

