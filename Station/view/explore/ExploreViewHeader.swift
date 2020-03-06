
import UIKit

protocol ExploreHeadDelegate {
    func showInfo()
    func showThought(atIndex index: Int)
    func scrollToBottom()
    var recentThoughts: [ThoughtPreview] { get }
    var subThoughtCount: BasicStatInfo { get }
    var thoughtCount: BasicStatInfo { get }
}

class ExploreViewHeader: UIView {
    init() {
        super.init(frame: CGRect(origin: .zero, size: .init(Device.width,  Device.height - (Device.tabBarheight / 2))))
        setStaticContent()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var station = UILabel.title("Station", .max)
    private var greeting = UILabel.mediumTitle()
    private var greetingIcon = Icons.iv(withImageType: .planet, size: .max)
    private var infoIcon = Icons.iv(withImageType: .info, size: .large)
    private var thoughtDisplay: ThoughtDisplay!
    private var subThoughtIconBar: BasicStatsBar!
    private var thoughtIconBar: BasicStatsBar!
    private var showOrbitsLabel = UILabel.directionLabel("Orbits", direction: .right)
    public var delegate: ExploreHeadDelegate? {
        didSet {
            setDisplays()
        }
    }
}


private extension ExploreViewHeader {

    func setStaticContent() {
        
        // station
        station.sizeToFit()
        station.left = left.addPadding(.xLarge)
        station.top = 60
        station.textColor = Styles.Colors.black
        addSubview(station)
        
        // greeting
        greeting.numberOfLines = 2
        greeting.text = String.timeSensativeGreeting()  + "\nGifton"
        greeting.textColor = Styles.Colors.darkGray
        greeting.sizeToFit()
        greeting.top = station.bottom.addPadding(.small)
        greeting.left = left.addPadding(.xLarge)
        addSubview(greeting)
        
        // greetingIcon
        greetingIcon.right = right.subtractPadding()
        greetingIcon.top = 40
        addSubview(greetingIcon)
        
        //infoIcon
        infoIcon.left = greeting.left
        infoIcon.top = greeting.bottom.addPadding()
        addSubview(infoIcon)
             
        // show OrbitsView
    }
    
    func setDisplays() {
        
        //thoughtDisplay
        thoughtDisplay = ThoughtDisplay(point: .init(0, greetingIcon.bottom), delegate: self)
        addSubview(thoughtDisplay)
        
        // stats bars
        if let del = delegate{
            print("confirmed del")
            thoughtIconBar = BasicStatsBar(point: .init(infoIcon.left, thoughtDisplay.bottom.addPadding(.xXLarge)), info: del.thoughtCount, withTitle: true)
            subThoughtIconBar = BasicStatsBar(point: .init(infoIcon.left, thoughtIconBar.bottom.addPadding(.medium)), info: del.subThoughtCount, withTitle: false)
            
            
            addSubview(subThoughtIconBar)
            addSubview(thoughtIconBar)
        }
        
    }
    
    func setTargets() { infoIcon.addTapGestureRecognizer(action: delegate?.showInfo) }
}

extension ExploreViewHeader: ThoughtDisplayDelegate {
    
    var thoughts: [ThoughtPreview] {
        return delegate?.recentThoughts ?? []
    }
    func selectedThought(atIndex index: Int) {
        delegate?.showThought(atIndex: index)
        
    }
    
}
