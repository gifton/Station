
import UIKit

final class Icons {
    
    enum IconSize  {
        case xXsmall, xSmall, small, medium, large, xLarge, xXlarge
    }
    
    enum IconType {
        case appIcon, thought, subThought, orbit, explore, close, new, info, appStore, email, arrow, camera, note, link, delete
    }
    
    static func iv(withImageType type: IconType, size: CGSize?) -> UIImageView {
        let iv =  UIImageView(frame: .init(origin: .zero, size: size ?? .init(40)))
        iv.image = iconForType(type)
        
        return iv
    }
    
    static func iconForType(_ type: IconType, frame: CGRect? = nil) -> UIImage? {
        
        var icon: UIImage? = UIImage()
        
        switch type {
        case .appIcon: icon = UIImage(named: "AppIcon")
        case .thought: icon =  UIImage(systemName: "icloud.fill")
        case .subThought: icon =  UIImage(named: "subthought")
        case .explore: icon =  UIImage(named: "explore")
        case .close: icon =  UIImage(systemName: "stop")
        case .delete: icon =  UIImage(systemName: "trash")
        case .new: icon =  UIImage(named: "new")
        case .info: icon =  UIImage(named: "info") // TODO: add icon
        case .appStore: icon =  UIImage(named: "appStore") // TODO: add icon
        case .email: icon =  UIImage(named: "email") // TODO: add icon
        case .arrow: icon =  UIImage(named: "arrow")
        case .camera: icon =  UIImage(systemName: "camera")
        case .note: icon =  UIImage(named: "note")
        case .link: icon = UIImage(systemName: "safari.fill")
        case .orbit: icon = UIImage(named: "orbit")
        }
        
        return icon?.cropped(to: frame)
    }
}
