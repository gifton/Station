
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
    
    let titleLabel = UILabel.mediumTitleLabel("create", .xXLarge)
    var delegate: CreateSubThoughtDelegate
    var camera: UIImageView!
    var note: UIImageView!
    var link: UIImageView!
}

private extension CreateSubThoughtView {
    func setView() {
        
        backgroundColor = Styles.Colors.primaryBlue
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
        camera.setShadow(color: .black, opacity: 0.35, offset: .init(0), radius: .init(3), viewCornerRadius: 0)
        addSubview(camera)
        
        // link
        link = Icons.iv(withImageType: .link, size: .init(30))
        link.tintColor = .white
        link.frame.origin = .init(camera.right.addPadding(.xLarge))
        link.center.y = titleLabel.center.y
        link.contentMode = .scaleAspectFit
        link.setShadow(color: .black, opacity: 0.35, offset: .init(0), radius: .init(3), viewCornerRadius: 0)
        addSubview(link)
        
        // note
        note = Icons.iv(withImageType: .note, size: .init(30))
        note.tintColor = .white
        note.frame.origin = .init(link.right.addPadding(.xLarge))
        note.center.y = titleLabel.center.y
        note.contentMode = .scaleAspectFit
        note.setShadow(color: .black, opacity: 0.35, offset: .init(0), radius: .init(3), viewCornerRadius: 0)
        addSubview(note)
        
        camera.addTapGestureRecognizer(action: delegate.newPhoto)
        note.addTapGestureRecognizer(action: delegate.newNote)
        link.addTapGestureRecognizer(action: delegate.newLink)
        
    }
}
