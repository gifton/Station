
import UIKit

protocol NewSubThoughtDelegate: ThoughtDetailCoordinator {
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
    private var preview: SubThoughtPreview?
    
    public var completion: (() -> (SubThoughtPreview))?
    weak public var delegate: NewSubThoughtDelegate?
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension NewSubThoughtController {
    func setView() {
        // type title
        let title = UILabel.body(String(describing: subThoughtType), .medium)
        title.sizeToFit()
        let icon = Icons.iv(withImageType: .subThought, size: .small)
        icon.tintColor = .black
        let stack = UIStackView(arrangedSubviews: [icon,  title], axis: .horizontal, spacing: 5, alignment: .leading, distribution: .fillProportionally)
        stack.frame = CGRect(origin: .init(Styles.Padding.xLarge.rawValue), size: .init(title.width + 5 + icon.width, max(icon.height,title.height)))
        
        let thoughtTitle = UILabel.title(self.thoughtTitle, .xLarge)
        thoughtTitle.sizeToFit()
        thoughtTitle.left = title.left
        thoughtTitle.top = stack.bottom.addPadding()
        
        view.addSubview(stack)
        view.addSubview(thoughtTitle)
        
        switch subThoughtType {
        case .image: setImageView()
        case .link: setLinkView()
        case .note: setNoteView()
        }
        
        saveButton.bottom = view.bottom.subtractPadding(.xLarge, multiplier: 4)
        saveButton.alpha = 0.3
        
        saveButton.addTapGestureRecognizer {
            self.preview = SubThoughtPreview(text: self.thoughtTextView.text, thought: nil)
            if let preview = self.preview {
                self.delegate?.createPreview(preview)
            }
        }
        view.addSubview(saveButton)
    }
    
    
    func setImageView() {
        
    }
    
    func setLinkView() {
        
        linkTextView.font = Styles.Font.body(ofSize: .large)
        linkTextView.layer.cornerRadius = 8
        linkTextView.frame = CGRect(x: CGFloat(0).addPadding(.xLarge), y: 150, width: view.width.subtractPadding(.xLarge, multiplier: 2), height: 45)
        linkTextView.textContainerInset = UIEdgeInsets(top: 15, left: 20, bottom: 20, right: 20)
        linkTextView.backgroundColor = Colors.white
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
        thoughtTextView.frame = CGRect(x: CGFloat(0).addPadding(.xLarge), y: 150, width: view.width.subtractPadding(.xLarge, multiplier: 2), height: saveButton.top.subtractPadding() - 150)
        thoughtTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        thoughtTextView.backgroundColor = Colors.white
        thoughtTextView.text = "Start typing..."
        thoughtTextView.autocapitalizationType = .sentences
        thoughtTextView.isEditable = true
        thoughtTextView.keyboardDismissMode = .onDrag
        thoughtTextView.returnKeyType = .done
        thoughtTextView.delegate = self
        
        view.addSubview(thoughtTextView)
        
    }
}

extension NewSubThoughtController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        saveButton.alpha = 1.0
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text != "" {
            saveButton.alpha = 1.0
        } else {
            saveButton.alpha = 0.3
        }
    }
}
