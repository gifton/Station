

import UIKit
import CoreLocation

// displaying thoughts in scroll views doenst require all thought data,
// this object makes passing data more concise
struct ThoughtPreview: DataPreview {
    var title:       String
    var date:        Date = Date()
    var location:    CLLocation?
    var orbits: [Orbit] = []
    var subThoughts: [SubThought] = []
    
    init(thought: Thought) {
        title = thought.title
        date = thought.createdAt
        
        location = thought.location
    }
    
    init(title: String, location: CLLocation?) {
        self.title = title
        self.location = location
        
        
    }
    
    static var zero: ThoughtPreview {
        return ThoughtPreview(title: "Awesome Photos on wesat", location: CLLocation())
    }
}


extension Array where Element == Thought {
    func toPreview() -> [ThoughtPreview] {
        return map { ThoughtPreview(thought: $0) }
    }
}
