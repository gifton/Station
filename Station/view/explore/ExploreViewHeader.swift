
import UIKit


protocol ExploreHeadDelegate: Controller {
    
    var recentThoughts: [ThoughtPreview] { get }
    func showThought(_  thought: ThoughtPreview)
    func showInfoButton()
    func scrollToBottom()
    
}

class ExploreViewHeader: UIView {
    init() {
        super.init(frame: CGRect(origin: .zero, size: Device.frame.size))
        setStaticContent()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var delegate: ExploreHeadDelegate? {
        didSet {
            setDisplays(); setTargets()
        }
    }
    
    private var station = UILabel.title("Station", .max)
    private var greeting = UILabel.mediumTitle()
    private var greetingIcon = Icons.iv(withImageType: .planet, size: .max)
    private var infoIcon = Icons.iv(withImageType: .info, size: .large)
    private var thoughtDisplay: ThoughtDisplay!
    private var subThoughtIconBar: BasicStatsBar!
    private var thoughtIconBar: BasicStatsBar!
    private var showOrbitsLabel = UILabel.directionLabel("Orbits", direction: .right)
    
}


private extension ExploreViewHeader {

    func setStaticContent() {
        station.sizeToFit()
        station.left = left.addPadding(.xLarge)
        station.top = 60
        station.textColor = Styles.Colors.black
        addSubview(station)
        
        greeting.numberOfLines = 2
        greeting.text = String.timeSensativeGreeting()  + "\nGifton"
        greeting.textColor = Styles.Colors.darkGray
        greeting.sizeToFit()
        greeting.top = station.bottom.addPadding(.small)
        greeting.left = left.addPadding(.xLarge)
        addSubview(greeting)
        
        greetingIcon.right = right.subtractPadding()
        greetingIcon.top = 40
        
        addSubview(greetingIcon)
    }
    
    func setDisplays() {
        
    }
    
    func setTargets() {
        infoIcon.addTapGestureRecognizer(action: delegate?.showInfoButton)
        
    }
}
