

import UIKit

open class UIController: UIViewController {
    
    // data manager
    var viewModel: ViewModel
    var collectionView: UICollectionView? { didSet { setCollectionView() } }
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
    
    func setCollectionView() {
        if let cv = collectionView {
            cv.delegate = self
            cv.dataSource = self
            cv.registerCell(UICollectionViewCell.self)
            // register classes
            view.addSubview(cv)
        }
    }
    
}

extension UIController: UICollectionViewDelegate {}

extension UIController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !dataIsSet {
            return 10
        } else {
            guard let vm = (viewModel as? ViewModelTableDataSource) else { return 1 }
            return vm.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !dataIsSet {
            
            let cell = collectionView.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath)
            cell.backgroundView = .init(withColor: Colors.primaryBlue)
            return cell
        }
        
        guard let vm = (viewModel as? ViewModelTableDataSource),
            let preview = vm.loadedPreview(forIndex: indexPath.row)
            else { return UICollectionViewCell() }
        
        switch preview.previewType {
        case .link:  return collectionView.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath)
        case .note: return collectionView.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath)
        case .image: return collectionView.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath)
        case .thought: return collectionView.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath)
        case .topic: return collectionView.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath)
        }
    }
    
//    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        if !dataIsSet { return 200 }
//        else {
//            guard let vm = (viewModel as? ViewModelTableDataSource),
//                let preview = vm.loadedPreview(forIndex: indexPath.row)
//                else { return 175 }
//
//            switch preview.previewType {
//            case .thought: return 96
//            case .topic: return 110
//            default: return (preview as? SubThoughtPreview)?.contentHeight ?? 100
//            }
//        }
//    }
//
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if !dataIsSet {
//            return 1
//        } else {
//            guard let vm = (viewModel as? ViewModelTableDataSource) else { return 1 }
//            return vm.count
//        }
//    }
}

extension UIController: ViewModelDelegate {
    
    func dataRecieved() {
        print("data is recieved")
        dataIsSet = true
        collectionView?.reloadData()
    }
    
    
}

