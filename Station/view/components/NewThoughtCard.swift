
import UIKit


// new thought card is where users input informatino for a new thought object to be createed

protocol NewThoughtCardDelegate {
    func titleUpdated()
    
}

class NewThoughtCard: UIView {
    
    init(point: CGPoint) {
        super.init(frame: CGRect(origin: point, size: CGSize(width: Device.width.subtractPadding(multiplier: 2), height: 200)))
        
        setView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var thoughtText: String {
        return thoughtTextView.text
    }
    
    var thoughtDelegate: NewThoughtCardDelegate?
    private var topView = UIView(withColor: Styles.Colors.lightGray)
    private var tapToStart = UILabel.body("tap to start", .large)
    private var thoughtTextView = UITextView()
    private var icon: UIImageView = UIImageView(image: Icons.iconForType(.thought)?.tintImage(toColor: Styles.Colors.darkGray))
    private var title = UILabel.mediumTitle("New Thought", .xLarge)
    
    func reset() {
        thoughtTextView.removeFromSuperview()
        thoughtTextView = UITextView()
        
        addTapToStart()
    }
}


private extension NewThoughtCard {
    
    func setView() {
        
        setShadow(color: .black, opacity: 0.115, offset: .init(0, -1), radius: 6.0, viewCornerRadius: 20)
        layer.cornerRadius = 20
        backgroundColor = Colors.hardBG
        
        addSubview(topView)
        topView.frame = CGRect(origin: .init(5), size: CGSize(width - 10, 54))
        topView.layer.cornerRadius = 20
        
        topView.addSubview(title)
        topView.addSubview(icon)
        title.sizeToFit()
        title.textColor = Styles.Colors.darkGray
        title.backgroundColor = .clear
        title.left = topView.left.addPadding()
        title.center.y = topView.center.y - 5
        
        icon.frame.size = CGSize(width: 35, height: 25)
        icon.right = topView.right.subtractPadding()
        icon.center.y = topView.center.y - 5
        
        addTapToStart()
        
    }
    
    func addTapToStart() {
        
        addSubview(tapToStart)
        tapToStart.sizeToFit()
        tapToStart.textColor = Styles.Colors.darkGray 
        tapToStart.center = CGPoint(width/2, 125)
        addTapGestureRecognizer(action: startThought)
        
    }
    
    func startThought() {
        tapToStart.removeFromSuperview()
        
        thoughtTextView.font =  Styles.Font.body(ofSize: .large)
        thoughtTextView.frame = CGRect(x: 0, y: topView.bottom, width: width, height: height - topView.height)
        thoughtTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        thoughtTextView.backgroundColor = .clear
        thoughtTextView.textColor = Colors.primaryText
        thoughtTextView.autocapitalizationType = .sentences
        thoughtTextView.isEditable = true
        thoughtTextView.keyboardDismissMode = .onDrag
        thoughtTextView.returnKeyType = .done
        thoughtTextView.delegate = self
        
        addSubview(thoughtTextView)
        thoughtTextView.becomeFirstResponder()
    }
    
}

extension NewThoughtCard: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        thoughtDelegate?.titleUpdated()
    }
}
