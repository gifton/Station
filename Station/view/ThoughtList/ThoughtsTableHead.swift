
import UIKit

protocol ThoughtTableHeadDelegate {
    func filter(withPredicate predicate: String)
    func showInfo()
    func showSortOptions()
    var numberOfThoughts: Int { get }
}

protocol ThoughtTableHeadController: UITableViewHeaderFooterView {
    func updateSortOption(_ option: SortOption)
}

class ThoughtTableHead: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public var  searchBar: UISearchBar!
    private var titleLable: UILabel!
    private var countView: UILabel!
    private var infoButton: UIImageView!
    private var sortButton: UILabel!
    
    public var delegate: ThoughtTableHeadDelegate? {
        didSet {
            setTargets()
            setCountView()
        }
    }
}


private extension ThoughtTableHead {
    func setView() {
        // titleLabel
        let img = Icons.iconForType(.thought)
        
        titleLable = UILabel.labelWithImage("Thoughts", image: img?.tintImage(toColor: Colors.primaryText), location: .left)
        titleLable.sizeToFit()
        titleLable.frame.origin = .init(30, Styles.Padding.xXLarge.rawValue)
        addSubview(titleLable)
        // searchBar
        searchBar = UISearchBar(frame: CGRect(origin: .init(Styles.Padding.large.rawValue, titleLable.bottom + Styles.Padding.medium.rawValue), size: .init(250, 45)))
        searchBar.placeholder = "Search for a thought"
        searchBar.autocapitalizationType = .none
        searchBar.backgroundImage = UIImage()
        searchBar.barStyle = .default
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        searchBar.showsCancelButton = false
        addSubview(searchBar)
        // infoButton
        infoButton = Icons.iv(withImageType: .info, size: .small)
        
        infoButton.right = Device.width.subtractPadding(.xLarge)
        infoButton.center.y = searchBar.center.y
        addSubview(infoButton)
        // sortButton
        sortButton = UILabel.body("Sort by: \(SortOption.dateDescending.rawValue)", .large)
        sortButton.textColor = Colors.primaryBlue
        sortButton.addBorders(edges: .bottom, color: Colors.primaryBlue)
        sortButton.sizeToFit()
        addSubview(sortButton)
        sortButton.left = left.addPadding(.xLarge)
        sortButton.top = searchBar.bottom  + Styles.Padding.small.rawValue
        
    }
    
    func setCountView() {
        // countView
        countView = UILabel.body(String(describing: delegate?.numberOfThoughts ?? 0), .medium)
        countView.sizeToFit()
        countView.textColor = Colors.primaryText
        countView.top = infoButton.bottom + Styles.Padding.large.rawValue// TODO: make helper func  for adding padding
        countView.center.x = infoButton.center.x
        addSubview(countView)
    }
    
    func setTargets()  {
        sortButton.addTapGestureRecognizer(action: delegate?.showSortOptions)
        infoButton.addTapGestureRecognizer(action: delegate?.showInfo)
    }
    
}

extension ThoughtTableHead: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        delegate?.filter(withPredicate: searchText)
    }
}

extension ThoughtTableHead: ThoughtTableHeadController {
    func updateSortOption(_ option: SortOption) {
        sortButton.text = "sort by: \(option.rawValue)"
        sortButton.sizeToFit()
    }
    
    
}
