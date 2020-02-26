
import UIKit

protocol NewSubThoughtDelegate: Controller {
    func createPreview(_ preview: SubThoughtPreview)
    
}

class NewSubThoughtController: Controller {
    init(controllerForType: SubThoughtType, title: String) {
        thoughtTitle = title
        self.subThoughtType = controllerForType
        super.init(nibName: nil, bundle: nil)
        
        setView()
    }
    
    public var saveButton = ConfirmationButton(point: .init(Styles.Padding.xLarge.rawValue, 500), color: .regular, text: "Save", width: .full)
    private var thoughtTitle: String
    private var subThoughtType: SubThoughtType
    private var thoughtTextView = UITextView()
    private var linkTextView = UITextView()
    private var pasteFromClipboard = ConfirmationButton(point: .zero, color: .light, text: "paste from clipoard", width: .half)
    public var completion: (() -> (SubThoughtPreview))?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension NewSubThoughtController {
    func setView() {
        let title = UILabel.bodyLabel(String(describing: subThoughtType), .medium)
        let thoughtTitle = UILabel.titleLabel(self.thoughtTitle, .xLarge)
        
        title.sizeToFit()
        thoughtTitle.sizeToFit()
        
        title.left = Styles.Padding.large.rawValue
        title.top = Styles.Padding.xXLarge.rawValue
        
        thoughtTitle.left = title.left
        thoughtTitle.top = title.bottom.addPadding()
        
        view.addSubview(title)
        view.addSubview(thoughtTitle)
        
        switch subThoughtType {
        case .image: setImageView()
        case .link: setLinkView()
        case .note: setNoteView()
        }
        
        saveButton.bottom = view.bottom.subtractPadding(.xLarge, multiplier: 4)
        view.addSubview(saveButton)
    }
    
    
    func setImageView() {
        
    }
    
    func setLinkView() {
        
        linkTextView.font = Styles.Font.body(ofSize: .large)
        linkTextView.layer.cornerRadius = 8
        linkTextView.frame = CGRect(x: CGFloat(0).addPadding(.xLarge), y: 150, width: view.width.subtractPadding(.xLarge, multiplier: 2), height: 45)
        linkTextView.textContainerInset = UIEdgeInsets(top: 15, left: 20, bottom: 20, right: 20)
        linkTextView.backgroundColor = Styles.Colors.white
        linkTextView.text = "Start typing..."
        linkTextView.autocapitalizationType = .sentences
        linkTextView.isEditable = true
        linkTextView.keyboardDismissMode = .onDrag
        linkTextView.returnKeyType = .done
        linkTextView.delegate = self
        view.addSubview(linkTextView)
    }
    
    func setNoteView() {
        
        thoughtTextView.font =  Styles.Font.body(ofSize: .large)
        thoughtTextView.layer.cornerRadius = 10
        thoughtTextView.frame = CGRect(x: CGFloat(0).addPadding(.xLarge), y: 150, width: view.width.subtractPadding(.xLarge, multiplier: 2), height: 200)
        thoughtTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        thoughtTextView.backgroundColor = Styles.Colors.white
        thoughtTextView.text = "Start typing..."
        thoughtTextView.autocapitalizationType = .sentences
        thoughtTextView.isEditable = true
        thoughtTextView.keyboardDismissMode = .onDrag
        thoughtTextView.returnKeyType = .done
        thoughtTextView.delegate = self
        view.addSubview(thoughtTextView)
        
    }
}

extension NewSubThoughtController: UITextViewDelegate { }
