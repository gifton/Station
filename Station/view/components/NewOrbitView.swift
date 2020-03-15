
import UIKit

protocol NewOrbitViewDelegate: UIView {
    func savePreview(_ preview: OrbitPreview)
}

class NewOrbitView: UIView {
    init(point: CGPoint, delegate: NewOrbitViewDelegate) {
        self.delegate = delegate
        super.init(frame: CGRect(origin: point, size: .init(Device.width.subtractPadding(.large, multiplier: 2), 55)))
        setView()
    }
    
    private var delegate: NewOrbitViewDelegate
    public  var saveButton = UILabel.body("Save", .large)
    private var iconView = UITextView()
    private var titleView = UITextField()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NewOrbitView {
    func setView() {
        backgroundColor = Colors.primaryGreen
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        iconView.frame.size = .init(45)
        iconView.top = 5
        iconView.left = 5
        iconView.text = "☁️"
        iconView.textAlignment = .center
        iconView.font = Styles.Font.mediumTitle()
        iconView.backgroundColor = .clear
        iconView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        iconView.addBorders(edges: .bottom, color: .white)
        iconView.delegate = self
        addSubview(iconView)
        
        titleView.frame.size = .init(200, 45)
        titleView.left = iconView.right.addPadding()
        titleView.top = 5
        titleView.text = "New Orbit Title"
        titleView.textColor = Colors.offWhite
        titleView.delegate = self
        addSubview(titleView)
        
        saveButton.frame.size = .init(85, 45)
        saveButton.right = right.subtractPadding(.xLarge)
        saveButton.top = 5
        saveButton.layer.cornerRadius = 15
        saveButton.layer.masksToBounds = true
        saveButton.textAlignment = .center
        saveButton.textColor = Colors.primaryGreen
        saveButton.backgroundColor = Colors.hardBG
        saveButton.addTapGestureRecognizer(action: save)
        addSubview(saveButton)
        
    }
    
    func save() {
        if let title = titleView.text {
            delegate.savePreview(OrbitPreview(title: title, icon: iconView.text))
            UIView.animate(withDuration: 0.25, animations: {
                self.saveButton.frame.size.width += 5
                self.saveButton.frame.size.height += 5
                self.saveButton.frame.origin.y -= 2.5
                self.saveButton.frame.origin.x -= 2.5
            }) { (_) in
                self.saveButton.frame.size.width -= 5
                self.saveButton.frame.size.height -= 5
                self.saveButton.frame.origin.y += 2.5
                self.saveButton.frame.origin.x += 2.5
            }
            
            iconView.text = "☁️"
            titleView.text  = "New Orbit Title"
        }
    }
}

extension NewOrbitView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text =  ""
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
    }
}

extension NewOrbitView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let newPosition = textView.endOfDocument
        textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        var tempIcon = String()
        if (textView.text.contains("\n")) {
            tempIcon = String(describing: textView.text.first!)
            textView.resignFirstResponder()
            textView.text = tempIcon
        }
        
        if textView.text.count > 1 {
            
            textView.text = "\(textView.text!.last!)"
        }
    }
}
