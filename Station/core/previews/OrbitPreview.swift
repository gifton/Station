
import UIKit

// TODO: define validity 
final class OrbitPreview: DataPreview {
    var title: String
    var createdAt: Date
    var relatedThoughts: [Thought]?
    var icon: String
    
    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
        
        createdAt = Date()
    }
    
    convenience init(_ orbit: Orbit) {
        self.init(title: orbit.title, icon: orbit.icon)
        relatedThoughts = orbit.relatedThoughts
    }
}
