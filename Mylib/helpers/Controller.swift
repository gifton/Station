

import UIKit

// custom viewController wrapper
// added functinoality for all viewControllers
// controller has standard objects for collectionviews, tableViews, scrollViews, and datamanagers
// standard deinit code
class Controller: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Styles.Colors.offWhite
    }
    
    // MARK: - Message Error
    func showMessage(title: String, message: String, handler: ((_ action: UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK publicly available variables
    // collectionView
    // set delegate and dataSource to self automatically
    var collectionView: UICollectionView? {
        didSet {
            if let collection = collectionView {
                collection.dataSource = self
                collection.delegate = self
                collection.registerCell(UICollectionViewCell.self)
                view.addSubview(collection)
                print("added collection")
            }
        }
    }
    
    // TableView
    // set delegate and dataSource to self automatically
    var tableView: UITableView? {
        didSet {
            
            setTableView()
        }
    }
    
    // scrollView
    var scrollView: UIScrollView? {
        didSet {
            if let scroll = scrollView {
                scroll.delegate = self
                view.addSubview(scroll)
            }
        }
    }
    
    // regular view
    var displayView: UIView? {
        didSet (v) {
            if let view = v {
                self.view = view
            }
        }
    }
    
    // data manager
    var dataManager: DataManager? {
        didSet(manager) {
            if let dm = manager {
                dm.delegate = self
            }
        }
    }
    
    // deinit method
    func controllerWillDeInit() {
        
        collectionView = nil
        tableView = nil
        scrollView = nil
        displayView = nil
        dataManager = nil
        
        print("controller deinit'd:", self)
        
    }
    
    deinit {
        controllerWillDeInit()
    }
    
    // faliure
    func faluire(to failure: Failure) {
        switch failure {
        case .toConnect: print("failure to connect to servers")
        default: print("failure: \(failure)")
        }
    }
    
}

private extension Controller {
    func setTableView() {
        if let table = tableView {
            table.delegate = self
            table.dataSource = self
            table.register(cellWithClass: LongOrbitCell.self)
            view.addSubview(table)
            
        } else {
            print("no tv found")
        }
    }
}

extension Controller: DataManagerDelegate {
    func data<T>() -> T where T : DataPreview {
        return ThoughtPreview.zero as! T
    }
    
    
    func data(isSet success: Bool) {
        
        if success {
            
            print("data for controller: \(self) is set")
            collectionView?.reloadData()
            tableView?.reloadData()
            
        } else {
            
            showMessage(title: "unable to prossess data", message: "ok")
            
        }
        
    }
}


enum Failure {
    
    case toConnect
    case toRetrieveData(ofType: Any)
    case toDisplayData(ofType: Any)
    
}


extension Controller: UITableViewDelegate { }
extension Controller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}


extension Controller: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath)
        cell.backgroundView = .init(withColor: .random)
        
        return cell
        
    }
    
    
}


extension Controller: UICollectionViewDelegate {
    
}
