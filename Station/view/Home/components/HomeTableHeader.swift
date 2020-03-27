
import UIKit

protocol HomeHeadDelegate: AnyObject {
    func search(forPredicate predicate: String)
    func showFilters()
    func showTopics()
    func selectedColorChange(_ light: Bool)
}

final class HomeTableHeader: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setStaticContent()
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate(_ delegate: HomeHeadDelegate) {
        setView()
        setTargets()
    }
    
    // private vars
    private var greeting = UILabel.body()
    private var date     = UILabel.mediumTitle()
    private var searchBar: UISearchBar!
    private var filter   =  UIImageView()
    private var topics   = UILabel()
    private var theme    =  UIImageView()
    

}


private extension HomeTableHeader {

    func setStaticContent() {
        
        // greeting
        greeting.numberOfLines = 2
        greeting.text = String.timeSensativeGreeting() + ","  + "\nGifton"
        greeting.textColor = Colors.primaryText
        greeting.sizeToFit()
        greeting.top = bounds.top.addPadding(.small)
        greeting.left = left.addPadding(.xLarge)
        addSubview(greeting)
        
        
             
        
        
    }
    
    func setView() {
        
    }
    
    func setTargets() {
        
        
    }
}
