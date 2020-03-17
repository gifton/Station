
import UIKit

protocol ExploreHeadDelegate: AnyObject {
    func showInfo()
    func showThought(atIndex index: Int)
    func scrollToBottom()
    var recentThoughts: [ThoughtPreview] { get }
    var subThoughtCount: BasicStatInfo { get }
    var thoughtCount: BasicStatInfo { get }
}

final class ExploreViewHeader: UIView {
    init() {
        super.init(frame: CGRect(origin: .zero, size: .init(Device.width,  Device.height - Device.tabBarheight)))
        setStaticContent()
        backgroundColor = Colors.hardBG
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // private vars
    private var station = UILabel.title("Station", .max)
    private var greeting = UILabel.mediumTitle()
    private var greetingIcon = Icons.iconView(withImageType: .planet, size: .max)
    private var infoIcon = Icons.iconView(withImageType: .info, size: .large)
    private var thoughtDisplay: ThoughtDisplay!
    private var subThoughtIconBar: BasicStatsBar!
    private var thoughtIconBar: BasicStatsBar!
    private var showOrbitsLabel = UILabel.directionLabel("Orbits", direction: .right)
    private var dirStack: UIStackView!
    
    weak public var delegate: ExploreHeadDelegate? {
        didSet {
            setDisplay()
            setTargets()
        }
    }
    
    deinit {
        delegate = nil
    }
}


private extension ExploreViewHeader {

    func setStaticContent() {
        
        // station
        station.sizeToFit()
        station.left = left.addPadding(.xLarge)
        station.top = 60
        station.textColor = Colors.primaryText
        addSubview(station)
        
        // greeting
        greeting.numberOfLines = 2
        greeting.text = String.timeSensativeGreeting()  + "\nGifton"
        greeting.textColor = Colors.secondaryText
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
             
        
        
    }
    
    func setDisplay() {
        
        //thoughtDisplay
        thoughtDisplay = ThoughtDisplay(point: .init(0, greetingIcon.bottom), delegate: self)
        thoughtDisplay.delegate = self
        addSubview(thoughtDisplay)
        
        // stats bars
        if let del = delegate{
            
            thoughtIconBar = BasicStatsBar(
                point: .init(infoIcon.left, thoughtDisplay.bottom.addPadding(.xXLarge)),
                info: del.thoughtCount,
                withTitle: true
            )
            
            subThoughtIconBar = BasicStatsBar(
                point: .init(infoIcon.left, thoughtIconBar.bottom.addPadding(.medium)),
                info: del.subThoughtCount,
                withTitle: false
            )
            
            addSubview(thoughtIconBar)
            addSubview(subThoughtIconBar)
        }
        
        // show OrbitsView
        // directionLabel
        let dirLabel = UILabel.body("Sub Thoughts ", .medium)
        dirLabel.textColor = Colors.black
        dirLabel.sizeToFit()
        let dirImage = UIImageView(image: Icons.iconForType(.arrow)!
        .scaled(toHeight: 20.0)?
        .rotate(radians: -1 * (.pi / 2))
        .tintImage(toColor: .black))
        
        dirStack = UIStackView(arrangedSubviews: [dirLabel, dirImage], axis: .horizontal, spacing: 2, alignment: .center, distribution: .fillProportionally)
        dirStack.frame.size = .init(dirLabel.width + dirImage.width + 2, 25)
        dirStack.top = subThoughtIconBar.bottom.addPadding(.xLarge)
        dirStack.center.x = width / 2
        
        addSubview(dirStack)
    }
    
    func setTargets() {
        infoIcon.addTapGestureRecognizer(action: delegate?.showInfo)
        dirStack.addTapGestureRecognizer(action: delegate?.scrollToBottom)
    }
}

extension ExploreViewHeader: ThoughtDisplayDelegate {
    
    var thoughts: [ThoughtPreview] {
        return delegate?.recentThoughts ?? []
    }
    func selectedThought(atIndex index: Int) {
        delegate?.showThought(atIndex: index)
        
    }
    
}
