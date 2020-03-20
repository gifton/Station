
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
    internal var linkTextView = UITextField()
    internal let camFrame = CGRect(x: 0, y: 100, width: Device.width, height: 500)
    internal lazy var outputImage = UIImageView()
    internal var pasteFromClipboard = ConfirmationButton(
        point: .zero,
        color: .monoChrome,
        text: "paste from clipoard",
        width: .third,
        font: Styles.Font.body()
    )
    internal var preview: SubThoughtPreview? {
        didSet {
            saveButton.alpha = 1.0
        }
    }
    
    /// link content
    internal var linkPreview: LinkPreview! {
        didSet {
            setLinkPreview()
            preview = SubThoughtPreview(link: linkPreview.link, thought: nil)
        }
    }
    /// image content
    // MARK: Private vars
    internal var captureSession: AVCaptureSession!
    internal var stillImageOutput: AVCapturePhotoOutput!
    internal lazy var interactionLabel = UILabel()
    internal var cameraPreviewLayer: AVCaptureVideoPreviewLayer!
    internal lazy var imagePicker = UIImagePickerController()
    
    internal var linkErrorLabel = UILabel.body("please  enter a  vlid link", .xLarge)
    internal lazy var linkIcon = UIImageView()
    internal lazy var linkDescription = UILabel.body()
    internal lazy var linkTitle = UILabel.title()
    internal lazy var slp = SwiftLinkPreview(session: URLSession.shared,
        workQueue: SwiftLinkPreview.defaultWorkQueue,
        responseQueue: DispatchQueue.main,
        cache: DisabledCache.instance
    )
    weak public var delegate: NewSubThoughtDelegate?
    
    deinit {
        delegate = nil
        endSession()
        captureSession = nil
        stillImageOutput  = nil
        cameraPreviewLayer = nil
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
        saveButton.layer.cornerRadius = saveButton.height / 2
        view.addSubview(saveButton)
        saveButton.addTapGestureRecognizer {
            if let preview = self.preview { self.delegate?.createPreview(preview) }
        }
        
        // style line
        let styleLine = UIView(withColor: Colors.primaryText)
        styleLine.frame = CGRect(x: Styles.Padding.xLarge.rawValue, y: thoughtTitle.bottom.addPadding(), width: view.width.subtractPadding(.xLarge, multiplier: 2), height: 1.5)
        styleLine.layer.cornerRadius = 0.75
        view.addSubview(styleLine)
        
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
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        preview = SubThoughtPreview(text: textView.text, thought: nil)
        return true
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text != "" { saveButton.alpha = 1.0 }
        else { saveButton.alpha = 0.3 }
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

