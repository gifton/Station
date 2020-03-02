

import UIKit

// MARK: CGPoint helper methods
extension CGPoint {
    
    // Creates a point with unnamed arguments.
    public init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x,  y: y)
    }
    
    // point from single value
    public init(_ size: CGFloat)  {
        self.init(x: size, y: size)
    }
    
}
