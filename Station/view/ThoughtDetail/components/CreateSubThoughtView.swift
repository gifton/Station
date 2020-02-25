
import UIKit

class CreateSubThoughtView: UIView {
    init(withDelegate delegate: CreateSubThoughtDelegate, point: CGPoint) {
        self.delegate = delegate
        super.init(frame: CGRect(origin: point, size: .init(Device.width, Device.tabBarheight)))
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel = UILabel.bodyLabel("create", .xXLarge)
    private var delegate: CreateSubThoughtDelegate
    private var camera: UIImageView!
    private var note: UIImageView!
    private var link: UIImageView!
}

private extension CreateSubThoughtView {
    func setView() {
        
        backgroundColor = Styles.Colors.secondaryGray
        addSubview(titleLabel)
        titleLabel.sizeToFit()
        titleLabel.textColor = .white
        titleLabel.left = left.addPadding(.xXLarge)
        titleLabel.center.y = (height / 2).subtractPadding(.small)
        
        setIcons()
        
    }
    
    func setIcons() {
        
        // camera
        camera = Icons.iv(withImageType: .camera, size: .init(38))
        camera.tintColor = .white
        camera.frame.origin = .init(Device.width  / 2)
        camera.center.y = titleLabel.center.y
        camera.contentMode = .scaleAspectFit
        addSubview(camera)
        
        // link
        link = Icons.iv(withImageType: .link, size: .init(30))
        link.tintColor = .white
        link.frame.origin = .init(camera.right.addPadding(.xLarge))
        link.center.y = titleLabel.center.y
        link.contentMode = .scaleAspectFit
        addSubview(link)
        
        // note
        note = Icons.iv(withImageType: .note, size: .init(30))
        note.tintColor = .white
        note.frame.origin = .init(link.right.addPadding(.xLarge))
        note.center.y = titleLabel.center.y
        note.contentMode = .scaleAspectFit
        addSubview(note)
        
        camera.addTapGestureRecognizer(action: delegate.newPhoto)
        note.addTapGestureRecognizer(action: delegate.newNote)
        link.addTapGestureRecognizer(action: delegate.newLink)
        
    }
}
