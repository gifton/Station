
import UIKit


// UILabel is the easiest way to display immutable text on screen
extension UILabel {
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }
    
    //add padding to  label
    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }
    
    // set text to date
    func getStringFromDate(date: Date, withStyle style: DateFormatter.Style) {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = style
            formatter.timeStyle = .none
            formatter.doesRelativeDateFormatting = false
            formatter.formattingContext = .standalone
            return formatter
        }()
        let output = dateFormatter.string(from: date)
        self.text = output
    }
    
    // set text to date time
    func setStringFromDateTime(date: Date, withStyle style: DateFormatter.Style) {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = style
            formatter.timeStyle = .short
            formatter.doesRelativeDateFormatting = false
            formatter.formattingContext = .standalone
            return formatter
        }()
        let output = dateFormatter.string(from: date)
        self.text = output
    }
    
    // API date format is a string  with SWAPI conformance
    // method  takes string,  and  outputs an optional date
    func setDateFromStringFormat(_ payload: String, length: DateFormatter.Style) {
        
        let df = DateFormatter()
        if let date = df.date(rawString: payload) {
            setStringFromDateTime(date: date, withStyle: length)
        }
        
    }
    
    // Required height for a label
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: Styles.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    // add shadow to label (usually used on top of images)
    public func set(textWithShadow content: String, lightShadow light: Bool = false, color: UIColor = .black) {
        
        // init shadow and set blur radius
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 10
        // give color based on param
        if light { shadow.shadowColor = UIColor.white.cgColor }
        else { shadow.shadowColor = UIColor.black.cgColor }
        
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 36),
            .foregroundColor: color,
            .shadow: shadow
        ]
        
        let attributedText = NSAttributedString(string: content, attributes: attrs)
        
        // set attribute to self
        self.attributedText = attributedText
    }
    
    func textDropShadow(_ color: UIColor = .black) {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.shadowColor = color.cgColor
    }
    
    convenience init(_ payload: String?) {
        self.init()
        text = payload
    }
}


// extensions for label with preset fonts & sizes
extension UILabel {
    
    // titlelabel
    static func titleLabel(_ payload: String? = nil, _ fontSize: Styles.FontSize = .xXLarge) -> UILabel {
        let lbl = UILabel(payload)
        lbl.font = Styles.Font.title(ofSize: fontSize)
        lbl.textColor = Styles.Colors.darkGray
        lbl.sizeToFit()
        
        return lbl
    }
    
    // titlelabel
    static func bodyLabel(_ payload: String? = nil, _ fontSize: Styles.FontSize = .medium) -> UILabel {
        let lbl = UILabel(payload)
        lbl.font = Styles.Font.body(ofSize: fontSize)
        lbl.sizeToFit()
        
        return lbl
    }
    
    // mediumtitle
    static func mediumTitleLabel(_ payload: String? = nil, _ fontSize: Styles.FontSize = .xLarge) -> UILabel {
        let lbl = UILabel(payload)
        lbl.font = Styles.Font.mediumTitle(ofSize: fontSize)
        lbl.sizeToFit()
        
        return lbl
    }
    
    // titlelabel
    static func lightBodyLabel(_ payload: String? = nil, _ fontSize: Styles.FontSize = .small) -> UILabel {
        let lbl = UILabel(payload)
        lbl.font = Styles.Font.lightBody(ofSize: fontSize)
        lbl.sizeToFit()
        
        return lbl
    }
}
