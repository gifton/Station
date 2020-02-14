
import UIKit


// new thought card is where users input informatino for a new thought object to be createed

protocol NewThoughtViewDelegate {
    func newThought(withTitle title: String)
    
}

class NewThoughtCard: UIView {
    
    init(point: CGPoint) {
        super.init(frame: CGRect(origin: point, size: CGSize(width: Device.width - (Styles.Padding.medium.rawValue * 2), height: 200)))
        setView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var thoughtText: String {
        return thoughtTextView.text
    }
    var delegate: NewThoughtViewDelegate?
    private var topView = UIView(withColor: .white)
    private var tapToStart = UILabel.bodyLabel("tap to start", .large)
    private var thoughtTextView = UITextView()
    private var icon: UIImageView = UIImageView(image: UIImage(color: Styles.Colors.accentBlue))
    private var title = UILabel.mediumTitleLabel("New Thought", .xLarge)
}


private extension NewThoughtCard {
    func setView() {
        setShadow(color: .black, opacity: 0.35, offset: CGSize(width: 0, height: -2), radius: 4.0, viewCornerRadius: 8)
        layer.cornerRadius = 8
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
        layer.masksToBounds = true
        backgroundColor = Styles.Colors.lightGray
        
        addSubview(topView)
        topView.frame = CGRect(origin: .zero, size: CGSize(width, 54))
        topView.addSubview(title)
        topView.addSubview(icon)
        title.sizeToFit()
        title.left = topView.left + Styles.Padding.large.rawValue
        title.top = topView.top + Styles.Padding.large.rawValue
        
        icon.frame.size = CGSize(width: 35, height: 25)
        icon.right = topView.right - Styles.Padding.large.rawValue
        icon.top = topView.top + Styles.Padding.large.rawValue
        
        
        addSubview(tapToStart)
        tapToStart.sizeToFit()
        tapToStart.center = CGPoint(width/2, 125)
        
        addTapGestureRecognizer(action: startThought)
    }
    
    func startThought() {
        tapToStart.removeFromSuperview()
        
        thoughtTextView.font =  Styles.Font.body(ofSize: .large)
        thoughtTextView.frame = CGRect(x: 0, y: topView.bottom, width: width, height: height - topView.height)
        thoughtTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        thoughtTextView.backgroundColor = .clear
        thoughtTextView.autocapitalizationType = .sentences
        thoughtTextView.isEditable = true
        thoughtTextView.text = "This is where you would type a thoughtThis is where you would type a thoughtThis is where you would type a thoughtThis is where you would type a thoughtThis is where you would type a thought"
        addSubview(thoughtTextView)
    }
    
}
