
import UIKit


class SubThoughtIcon: UIView {
    init(type: SubThoughtType) {
        super.init(frame: CGRect(origin: .zero, size: .init(95)))
        
        backgroundColor = Styles.Colors.offWhite
        layer.cornerRadius = 8
        layer.masksToBounds = true
        let label = UILabel.body("", .medium)
        let img = UIImageView()
        switch type {
        case .note:
            label.text = "note"
            img.image = Icons.iconForType(.note)?.tintImage(toColor: .black)
        case .link:
            img.image = Icons.iconForType(.link)?.tintImage(toColor: .black)
            label.text  = "link"
        case .image:
            img.image = Icons.iconForType(.camera)?.tintImage(toColor: .black)
            label.text  = "photo"
        }
        
        img.frame.size = .init(20)
        img.contentMode = .scaleAspectFit
        img.center.x = width / 2
        img.top = Styles.Padding.large.rawValue
        addSubview(img)
        
        label.sizeToFit()
        label.bottom = bottom.subtractPadding(.xLarge)
        label.center.x = width / 2
        addSubview(label)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
