
import UIKit

// let view be initialized  with color parameter only
extension UIView {
    
    convenience init(withColor color: UIColor) {
        
        self.init()
        backgroundColor = color
        
    }
    
    /// The top coordinate of the UIView.
    public var top: CGFloat {
        get {
            return frame.top
        }
        set(value) {
            var frame = self.frame
            frame.top = value
            self.frame = frame
        }
    }
    
    /// The left coordinate of the UIView.
    public var left: CGFloat {
        get {
            return frame.left
        }
        set(value) {
            var frame = self.frame
            frame.left = value
            self.frame = frame
        }
    }
    
    /// The bottom coordinate of the UIView.
    public var bottom: CGFloat {
        get {
            return frame.bottom
        }
        set(value) {
            var frame = self.frame
            frame.bottom = value
            self.frame = frame
        }
    }
    
    /// The right coordinate of the UIView.
    public var right: CGFloat {
        get {
            return frame.right
        }
        set(value) {
            var frame = self.frame
            frame.right = value
            self.frame = frame
        }
    }
    
    // The width of the UIView.
    public var width: CGFloat {
        get {
            return frame.width
        }
        set(value) {
            var frame = self.frame
            frame.size.width = value
            self.frame = frame
        }
    }
    
    // The height of the UIView.
    public var height: CGFloat {
        get {
            return frame.height
        }
        set(value) {
            var frame = self.frame
            frame.size.height = value
            self.frame = frame
        }
    }
    
    /// The horizontal center coordinate of the UIView.
    public var centerX: CGFloat {
        get {
            return frame.centerX
        }
        set(value) {
            var frame = self.frame
            frame.centerX = value
            self.frame = frame
        }
    }
    
    /// The vertical center coordinate of the UIView.
    public var centerY: CGFloat {
        get {
            return frame.centerY
        }
        set(value) {
            var frame = self.frame
            frame.centerY = value
            self.frame = frame
        }
    }
    
    
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "GenericMethodAssociatedObjectKey_FireByTap"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func removeTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.removeGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    // create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addHoldGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let holdGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleTapGesture))
        
        self.addGestureRecognizer(holdGestureRecognizer)
    }
    
    // return parent viewController optionally
    var viewController: UIViewController? {
        var parent: UIResponder? = self
        while parent != nil {
            parent = parent?.next
            if let viewController = parent as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}



extension UIView {
    
    // pin funcs
    func pin(onEdge edge: UIRectEdge, withPadding: Styles.Padding = .large) {
        
        guard let sv = superview else {
            print("make sure you've added the view to its superview before calling pin()")
            return
        }
        
        switch edge {
        case .bottom: bottom = sv.bottom - withPadding.rawValue
        case .right: right = sv.right - withPadding.rawValue
        case .top: top = withPadding.rawValue
        case .left: left = withPadding.rawValue
        default: print("unable to create layout based on parameters")
        }
    }
    
    func constrainSize(_ size: CGSize)  {
        translatesAutoresizingMaskIntoConstraints = false
        
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        
        widthAnchor.constraint(equalToConstant: size.width).isActive = true

    }
    
    func constrain(toEdge edge: NSLayoutConstraint.Attribute, withPadding padding: Styles.Padding = .large) {
        guard let sv = superview else {
            print("make sure you've added the view to its superview before calling pin()")
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        switch edge {
        case .leading:
            leadingAnchor.constraint(equalTo: sv.leadingAnchor, constant: padding.rawValue).isActive = true
        case .top:
            topAnchor.constraint(equalTo: sv.topAnchor, constant: padding.rawValue).isActive = true
        case .trailing:
            trailingAnchor.constraint(equalTo: sv.trailingAnchor, constant: padding.rawValue).isActive = true
        case .bottom:
            bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: padding.rawValue).isActive = true
        default:
            fatalError("requested edge is not availabel for autmatic constraining")
        }
    }
    
    func setShadow(color: UIColor?, opacity: Float?, offset: CGSize?, radius: CGFloat, viewCornerRadius: CGFloat?) {
        //layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: viewCornerRadius ?? 0.0).CGPath
        layer.shadowColor = color?.cgColor ?? UIColor.black.cgColor
        layer.shadowOpacity = opacity ?? 1.0
        layer.shadowOffset = offset ?? CGSize.zero
        layer.shadowRadius = radius
    }
}
