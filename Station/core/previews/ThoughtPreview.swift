

import UIKit
import CoreLocation

// displaying thoughts in scroll views doenst require all thought data,
// this object makes passing data more concise
struct ThoughtPreview: DataPreview {
    var title:       String
    var date:        Date = Date()
    var location:    CLLocation?
    private(set) var orbits: [Orbit] = []
    var subThoughts: [SubThought] = []
    
    init(thought: Thought) {
        title = thought.title
        date = thought.createdAt
        orbits = thought.computedOrbits
        subThoughts = thought.computedSubThoughts
        location = thought.location
    }
    
    init(title: String, location: CLLocation?) {
        self.title = title
        self.location = location
        
    }
    
    // return empty thought previw (error handleing)
    static var zero: ThoughtPreview {
        return ThoughtPreview(title: "Awesome Photos on wesat", location: CLLocation())
    }
    
    var subThoughtsInTheLastWeek: Int {
        return subThoughts.filter {
            $0.createdAt >= Date(timeIntervalSinceNow: -7 * 24 * 60 * 60)
        }.count
    }

    public mutating func addOrbit(_ orbit: Orbit) {
        orbits.append(orbit)
    }
}


extension Array where Element == Thought {
    func toPreview() -> [ThoughtPreview] {
        return map { ThoughtPreview(thought: $0) }
    }
}
