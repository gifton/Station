
import UIKit

protocol HomeHeadDelegate: AnyObject {
    func search(forPredicate predicate: String)
    func showFilters()
    func showTopics()
    func selectedColorChange(_ light: Bool)
}

final class HomeTableHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func setWithDelegate(_ delegate: HomeHeadDelegate) {
        print("set delegate")
        self.delegate = delegate
        setView()
        setTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let maxHeight: CGFloat = 275
    let minHeight: CGFloat = 100
    
    // private vars
    private var greeting = UILabel.body("", .xxXLarge)
    private var date     = UILabel.mediumTitle()
    private var searchBar: UISearchBar!
    private var filter   =  UIImageView()
    private var topics   = UILabel.body("Topics", .large)
    private var arrow: UIImageView!
    private var theme    =  UIImageView()
    private var topicStack: UIStackView!
    
    public weak var delegate:  HomeHeadDelegate?

    
    public func update(toProgress progress: CGFloat) {
        var newHeight: CGFloat = maxHeight
        if progress == 0 {
            newHeight = maxHeight
        } else if progress >= 0.636363637 {
            newHeight = minHeight
        } else {
            newHeight = height - ( 0 + (maxHeight - 0) * progress)
        }
        self.height = newHeight
        print("progress:\(progress), height: \(newHeight)")
    }
}


private extension HomeTableHeader {
    
    
    func setView() {
        topics.underline()
        topics.sizeToFit()
        topics.width += 10
        arrow = Icons.iconView(withImageType: .arrow, size: .xXsmall, color: .black)
        topicStack = UIStackView(arrangedSubviews: [arrow, topics], axis: .horizontal, spacing: 5, alignment: .leading, distribution: .fillProportionally)
        topicStack.frame.size = .init(topics.width + arrow.width + 20, max(topics.height, arrow.height))
        topicStack.left = CGFloat(0).addPadding(.xLarge)
        topicStack.top = CGFloat(0).addPadding(.large)
        addSubview(topicStack)
        
        greeting.text = String.timeSensativeGreeting() + ",\nGifton"
        greeting.numberOfLines = 2
        greeting.sizeToFit()
        greeting.textColor = Colors.primaryText
        greeting.top = topicStack.bottom.addPadding(.large, multiplier: 2)
        greeting.left = left.addPadding(.xLarge)
        addSubview(greeting)
        
        
    }
    
    func setTargets() {
        Tap.on(view: topicStack, fires: showTopics)
    }
    
    func showTopics() {
        delegate?.showTopics()
        topicStack.removeArrangedSubview(arrow)
        
        arrow.transform = CGAffineTransform(rotationAngle: .pi)
        
        topicStack.setNeedsLayout(); topicStack.layoutIfNeeded()
        topicStack.insertArrangedSubview(arrow, at: 1)
        
        topics.text = "Hide"
        topics.underline()
        
        topicStack.setNeedsLayout(); topicStack.layoutIfNeeded()
        
        Tap.remove(fromView: topicStack, action: showTopics)
        Tap.on(view: topicStack, fires: hideTopics)
    }
    
    func hideTopics() {
        delegate?.showTopics()
        topicStack.removeArrangedSubview(arrow)
        
        arrow.transform = CGAffineTransform.identity
        
        topicStack.setNeedsLayout(); topicStack.layoutIfNeeded()
        topicStack.insertArrangedSubview(arrow, at: 0)
        
        topics.text = "Topics"
        topics.underline()
        
        topicStack.setNeedsLayout(); topicStack.layoutIfNeeded()
        
        Tap.remove(fromView: topicStack, action: hideTopics)
        Tap.on(view: topicStack, fires: showTopics)
    }
}
