
import UIKit

protocol ThoughtTableHeadDelegate {
    func filter(withPredicate predicate: String)
    func showInfo()
    func showSortOptions()
    var numberOfThoughts: Int { get }
}

class ThoughtTableHead: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var searchBar: UISearchBar!
    private var titleLable: UILabel!
    private var countView: UILabel!
    private var infoButton: UIImageView!
    private var sortButton: UILabel!
    
    public var delegate: ThoughtTableHeadDelegate? {
        didSet {
            setTargets()
        }
    }
}


private extension ThoughtTableHead {
    func setView() {
        // titleLabel
        titleLable = UILabel.labelWithImage("Thoughts", image: Icons.iconForType(.thought), location: .left)
        titleLable.sizeToFit()
        titleLable.frame.origin = .init(Styles.Padding.xLarge.rawValue, Styles.Padding.xXLarge.rawValue)
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
        sortButton = UILabel.body("Sort by: date", .large)
        sortButton.textColor = Styles.Colors.primaryBlue
        sortButton.addBorders(edges: .bottom, color: Styles.Colors.primaryBlue)
        sortButton.sizeToFit()
        addSubview(sortButton)
        sortButton.left = left.addPadding(.xLarge)
        sortButton.top = searchBar.bottom  + Styles.Padding.small.rawValue
        // countView
        countView = UILabel.body(String(describing: delegate?.numberOfThoughts ?? 0), .medium)
        countView.sizeToFit()
        countView.textColor = Styles.Colors.darkGray
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
