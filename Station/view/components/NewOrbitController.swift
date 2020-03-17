
import UIKit

protocol NewOrbitDelegate: AnyObject {
    func saveOrbit(completion: () -> (Bool))
}



class NewOrbitController: UIViewController {
    
    weak public var delegate: NewOrbitDelegate?
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
        view.height = 500
        view.bottom = Device.height
        setView()
        
    }
    
    public var orbitIcon: String {
        return iconView.text
    }
        
    public var orbitTitle: String? {
        return titleView.text
    }
    
    public var saveButton = ConfirmationButton(point: .init(Styles.Padding.medium.rawValue, 0), color: .regular, text: "Save", width: .full)
    private var iconView = UITextView()
    private var titleView = UITextField()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        view.backgroundColor = Colors.offWhite
        
        // set title
        let titlelbl = UILabel.title("New Orbit", .large)
        view.addSubview(titlelbl)
        titlelbl.sizeToFit()
        titlelbl.center.x = view.center.x
        titlelbl.top = 40
        
        // set title view
        view.addSubview(titleView)
        titleView.backgroundColor = Colors.lightGray
        titleView.layer.cornerRadius = 13.5
        titleView.layer.masksToBounds = true
        titleView.placeholder = "Orbit name"
        titleView.frame.size = .init(Device.width - (Styles.Padding.xXLarge.rawValue * 2), 45)
        titleView.font = Styles.Font.body(ofSize: .large)
        titleView.textAlignment = .center
        titleView.center.x = view.center.x
        titleView.top = titlelbl.bottom + Styles.Padding.xXLarge.rawValue
        
        // set icon title
        iconView.frame.size = .init(100)
        iconView.backgroundColor = Colors.lightGray
        iconView.layer.cornerRadius = 13.5
        iconView.layer.masksToBounds = true
        iconView.isScrollEnabled = false
        iconView.delegate = self
        iconView.contentInset = .init(top: 10, left: 0, bottom: -10, right: 0)
        iconView.textAlignment = .center
        iconView.text = "☁️"
        iconView.font = Styles.Font.body(ofSize: .emoji)
        view.addSubview(iconView)
        iconView.center.x = view.center.x
        iconView.top = titleView.bottom + Styles.Padding.xXLarge.rawValue
        iconView.returnKeyType = .done
        
        view.addSubview(saveButton)
        // seet save button
        saveButton.bottom = view.bottom - 150
        
    }
    
}

extension NewOrbitController: UITextViewDelegate {
    //overrides the previous char
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
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let newPosition = textView.endOfDocument
        textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
    }
}
