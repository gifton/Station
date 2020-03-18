
import UIKit
import SwiftLinkPreview
import Kingfisher
import AVFoundation

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
    
    public var saveButton = ConfirmationButton(
        point: .init(Styles.Padding.xLarge.rawValue, 500),
        color: .regular,
        text: "Create Sub Thought",
        width: .full
    )
    private var thoughtTitle: String
    private var subThoughtType: SubThoughtType
    private var thoughtTextView = UITextView()
    private var linkTextView = UITextField()
    private var pasteFromClipboard = ConfirmationButton(
        point: .zero,
        color: .monoChrome,
        text: "paste from clipoard",
        width: .third,
        font: Styles.Font.body()
    )
    private var preview: SubThoughtPreview?
    
    /// link content
    private var linkPreview: LinkPreview! {
        didSet {
            setPreview()
            preview = SubThoughtPreview(link: linkPreview.link, thought: nil)
        }
    }
    /// image content
    // MARK: Private vars
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var interactionLabel = UILabel()
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    private var errorLabel = UILabel.body("please  enter a  vlid link", .xLarge)
    private lazy var linkIcon = UIImageView()
    private lazy var linkDescription = UILabel.body()
    private lazy var linkTitle = UILabel.title()
    private lazy var slp = SwiftLinkPreview(session: URLSession.shared,
        workQueue: SwiftLinkPreview.defaultWorkQueue,
        responseQueue: DispatchQueue.main,
        cache: DisabledCache.instance
    )
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

        // upper stack
        let stack = UIStackView(arrangedSubviews: [icon,  title], axis: .horizontal, spacing: Styles.Padding.large.rawValue, alignment: .leading, distribution: .fill)
        stack.frame = CGRect(origin: .init(Styles.Padding.xLarge.rawValue), size: .init(title.width + Styles.Padding.large.rawValue + icon.width, max(icon.height,title.height)))
        
        // thought title
        let thoughtTitle = UILabel.mediumTitle(self.thoughtTitle, .xLarge)
        thoughtTitle.numberOfLines = 0
        thoughtTitle.width = view.width.subtractPadding(.xLarge, multiplier: 2)
        thoughtTitle.sizeToFit()
        thoughtTitle.left = title.left.addPadding(.xLarge)
        thoughtTitle.top = stack.bottom.addPadding()
        
        view.addSubview(stack)
        view.addSubview(thoughtTitle)
        
        // type
        switch subThoughtType {
        case .image: setImageView()
        case .link: setLinkView()
        case .note: setNoteView()
        }
        
        // save button
        saveButton.bottom = view.bottom.subtractPadding(.xLarge, multiplier: 4)
        saveButton.alpha = 0.3
        view.addSubview(saveButton)
        saveButton.addTapGestureRecognizer {
            self.preview = SubThoughtPreview(text: self.thoughtTextView.text, thought: nil)
            if let preview = self.preview { self.delegate?.createPreview(preview) }
        }
        
        // style line
        let styleLine = UIView(withColor: Colors.primaryText)
        styleLine.frame = CGRect(x: Styles.Padding.xLarge.rawValue, y: thoughtTitle.bottom.addPadding(), width: view.width.subtractPadding(.xLarge, multiplier: 2), height: 1.5)
        styleLine.layer.cornerRadius = 0.75
        view.addSubview(styleLine)
        
    }
    
    
    func setImageView() {
        
        // TODO: implement image sourcing
        
        
    }
    
    func setLinkView() {
        
        linkTextView.font = Styles.Font.body(ofSize: .large)
        linkTextView.layer.cornerRadius = 8
        linkTextView.frame = CGRect(x: CGFloat(0).addPadding(.xLarge), y: 150, width: view.width / 1.75, height: 45)
        linkTextView.backgroundColor = Colors.white
        linkTextView.text = "Insert Link"
        linkTextView.autocapitalizationType = .sentences
        linkTextView.returnKeyType = .done
        linkTextView.delegate = self
        linkTextView.keyboardType = .URL
        
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
        if textView.text != "" { saveButton.alpha = 1.0 }
        else { saveButton.alpha = 0.3 }
    }
}

// link preview work
private extension NewSubThoughtController {
    
    func setPreview() {
        print("setting preview")
        linkIcon.frame.size = .init(150)
        linkIcon.center.x = view.bounds.center.x
        linkIcon.top = linkTextView.bottom.addPadding(.xLarge)
        linkIcon.kf.setImage(with: URL(string: linkPreview.iconURL))
        linkIcon.layer.cornerRadius  =  6
        linkIcon.layer.masksToBounds = true
        linkIcon.backgroundColor = .white
        view.addSubview(linkIcon)
        
        linkDescription.text = linkPreview.description
        linkDescription.numberOfLines = 0
        linkDescription.width = view.width.subtractPadding(.xXLarge, multiplier: 2)
        linkDescription.height = 100
        linkDescription.top = linkIcon.bottom.addPadding()
        linkDescription.center.x = view.center.x
        view.addSubview(linkDescription)
        
    }
    
    func checkURL(_ url: String?) {
        
        if let url = url {
            linkIcon.removeFromSuperview()
            linkDescription.removeFromSuperview()
            slp.preview(url, onSuccess: { (body) in
                self.linkPreview = .init(body) })
            { (error) in
                print(error)
                self.errorLabel.sizeToFit()
                self.errorLabel.center = self.view.bounds.center
                self.errorLabel.textColor = .red
                self.view.addSubview(self.errorLabel)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.errorLabel.removeFromSuperview()
                }
            }
        }
    }
    
    
}

extension NewSubThoughtController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkURL(textField.text)
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
