
import UIKit



import UIKit


// UIColor does not base its system off of hex, rather RGB(a)
// allows input as hex values instead of standard UIcolor init
public extension UIColor {
    
    convenience init(hex: String) {
        // trim chars
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        // remove hashtag (lol)
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        // return gray if all 3 colorcodes are not present
        if ((cString.count) != 6) {
            self.init(red: UIColor.gray.rgba.red, green: UIColor.gray.rgba.green, blue: UIColor.gray.rgba.blue, alpha: 1.0)
        }
        
        // find rgb by getting hex code of string from scanner
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        let color = UIColor (
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
        self.init(red: color.rgba.red, green: color.rgba.green, blue: color.rgba.blue, alpha: 1.0)
    }
    
    // set color to random set of hex values
    static var random: UIColor {
        let max = CGFloat(UInt32.max)
        let red = CGFloat(arc4random()) / max
        let green = CGFloat(arc4random()) / max
        let blue = CGFloat(arc4random()) / max
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    // retrieve RBG-A values from color
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}

// display color between to preset colors for animation
extension UIColor {
    func animate(toColor color: UIColor, withProgress progress: CGFloat) -> UIColor {
        return UIColor(red: rgba.red + (color.rgba.red - rgba.red) * progress,
                       green: rgba.green + (color.rgba.green - rgba.green) * progress,
                       blue: rgba.blue + (color.rgba.blue - rgba.blue) * progress, alpha: 1.0)
    }
}



