
import UIKit

 // MARK: Icons class
 // icons class lets user access saved icons/images through enums for defining type, and size.
 // available in ImageView or as standalone image
final class Icons {
    
    enum IconSize  {
        case xXsmall, xSmall, small, medium, large, xLarge, xXlarge, mmax
    }
    
    // icon types
    enum IconType {
        case appIcon, thought, subThought, orbit, explore, close, new, info, appStore, email, arrow, camera, note, link, delete
    }
    
    // imageView allows for propper size cropping of image
    // return image view with desired icon calling on iconForType(_) for content
    static func iv(withImageType type: IconType, size: IconSize?) -> UIImageView {
        let iv =  UIImageView(frame: .init(origin: .zero, size: sizeFor(size)))
        iv.image = iconForType(type)
        
        return iv
    }
    
    // return image from selected icon and size
    static func iconForType(_ type: IconType) -> UIImage? {
        
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
        
        return icon
    }

    // calculated icon sizes
    static func sizeFor(_ size: IconSize) -> CGSize {
        switch size {
            case .xXsmal: return .init(10)
            case .xSmall: return .init(15)
            case .small: return .init(20)
            case .medium: return .init(25)
            case .large: return .init(40)
            case .xLarge: return .init(50)
            case .xXlarge: return .init(100)
            case .max: return .init(Device.width / 2)
        }
    } 
}
