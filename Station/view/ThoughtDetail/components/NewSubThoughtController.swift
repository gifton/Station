
import UIKit
import SwiftLinkPreview

protocol NewSubThoughtDelegate: ThoughtDetailCoordinator {
    func createPreview(_ preview: SubThoughtPreview)
}

final class NewSubThoughtController: Controller {
    init(controllerForType: SubThoughtType, title: String) {
        thoughtTitle = title
        self.subThoughtType = controllerForType
        super.init(nibName: nil, bundle: nil)
        
        setView()
    }
    
    public var saveButton = ConfirmationButton(point: .init(Styles.Padding.xLarge.rawValue, 500), color: .regular, text: "Create Sub Thought", width: .full)
    private var thoughtTitle: String
    private var subThoughtType: SubThoughtType
    private var thoughtTextView = UITextView()
    private var linkTextView = UITextView()
    private var pasteFromClipboard = ConfirmationButton(point: .zero, color: .monoChrome, text: "paste from clipoard", width: .third, font: Styles.Font.body())
    private var preview: SubThoughtPreview?
    
    weak public var delegate: NewSubThoughtDelegate?
    
    deinit {
        delegate = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension NewSubThoughtController {
    
    func setView() {
        // type title
        let title = UILabel.title(String(describing: subThoughtType), .medium)
        title.textColor = Colors.primaryBlue
        title.sizeToFit()
        
        let icon = Icons.iconView(withImageType: .orbit, size: .small, color: Colors.primaryBlue)

        let stack = UIStackView(arrangedSubviews: [icon,  title], axis: .horizontal, spacing: Styles.Padding.large.rawValue, alignment: .leading, distribution: .fill)
        stack.frame = CGRect(origin: .init(Styles.Padding.xLarge.rawValue), size: .init(title.width + Styles.Padding.large.rawValue + icon.width, max(icon.height,title.height)))
        
        let thoughtTitle = UILabel.mediumTitle(self.thoughtTitle, .xLarge)
        thoughtTitle.numberOfLines = 0
        thoughtTitle.width = view.width.subtractPadding(.xLarge, multiplier: 2)
        thoughtTitle.sizeToFit()
        thoughtTitle.left = title.left.addPadding(.xLarge)
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
        view.addSubview(saveButton)
        saveButton.addTapGestureRecognizer {
            self.preview = SubThoughtPreview(text: self.thoughtTextView.text, thought: nil)
            if let preview = self.preview { self.delegate?.createPreview(preview) }
        }
        
        let styleLine = UIView(withColor: Colors.primaryText)
        styleLine.frame = CGRect(x: Styles.Padding.xLarge.rawValue, y: thoughtTitle.bottom.addPadding(), width: view.width.subtractPadding(.xLarge, multiplier: 2), height: 2)
        styleLine.layer.cornerRadius = 1
        view.addSubview(styleLine)
        
    }
    
    
    func setImageView() {
        
    }
    
    func setLinkView() {
        
        linkTextView.font = Styles.Font.body(ofSize: .large)
        linkTextView.layer.cornerRadius = 8
        linkTextView.frame = CGRect(x: CGFloat(0).addPadding(.xLarge), y: 150, width: view.width / 1.75, height: 45)
        linkTextView.textContainerInset = UIEdgeInsets(top: 12.5, left: 20, bottom: 20, right: 20)
        linkTextView.backgroundColor = Colors.white
        linkTextView.text = "Add Link"
        linkTextView.autocapitalizationType = .sentences
        linkTextView.isEditable = true
        linkTextView.keyboardDismissMode = .onDrag
        linkTextView.returnKeyType = .done
        linkTextView.delegate = self
        
        pasteFromClipboard.left = linkTextView.right.addPadding()
        pasteFromClipboard.top = linkTextView.top
        pasteFromClipboard.height = linkTextView.height
        
        view.addSubview(linkTextView)
        view.addSubview(pasteFromClipboard)
    }
    
    func setNoteView() {
        
        thoughtTextView.font =  Styles.Font.body(ofSize: .large)
        thoughtTextView.layer.cornerRadius = 10
        thoughtTextView.frame = CGRect(x: CGFloat(0).addPadding(.xLarge), y: 150, width: view.width.subtractPadding(.xLarge, multiplier: 2), height: saveButton.top.subtractPadding() - 150)
        thoughtTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        thoughtTextView.backgroundColor = .clear
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
        textView.text = ""
        textView.textContainerInset = UIEdgeInsets(top: 12.5, left: 20, bottom: 20, right: 20)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text != "" {
            saveButton.alpha = 1.0
        } else {
            saveButton.alpha = 0.3
        }
    }
}

// link preview work
private extension NewSubThoughtController {
    func checkURL(_ url: String) {
        
    }
    
    
}
