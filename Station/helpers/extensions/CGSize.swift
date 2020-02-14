
import UIKit

extension CGSize {
    
    /// Creates a point with unnamed arguments.
    public init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width,  height: height)
    }
    
    public init(_ size: CGFloat)  {
        self.init(width: size, height: size)
    }
    
}
