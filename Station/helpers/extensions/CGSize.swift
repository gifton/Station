
import UIKit

// MARK: CGSize helper methods
extension CGSize {
    
    /// Creates a point with unnamed arguments.
    public init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width,  height: height)
    }
    
    // size from single value
    public init(_ size: CGFloat)  {
        self.init(width: size, height: size)
    }
    
}
