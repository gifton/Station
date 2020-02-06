

import CoreLocation
import UIKit

// thought accessables
// [Thought]
protocol ThoughtsDataAccessable: DataManager {
    func getPreviews(predicate: String?, completion: () -> ())
    
    func refresh()
}

// new thought
protocol ThoughtDataCreatorAccessable: DataManager {
    func create(withTitle title: String, andLocation location: CLLocation?, completion: (() -> ())?)
}

// single thought
protocol ThoughtAccessable: DataManager {
    func thoughtWithID()
}




// orbit accessors
// [orbit]
protocol OrbitPreviewDataAccessable: DataManager {
    func getPreviews(completion: () -> ())
}

// new orbit
protocol OrbitDataCreatorAccessable: DataManager {
    func create(withTitle: String, andIcon icon: String, completion: (() -> ())? )
}




// SubThought accessors
// [subThought]
protocol SubThoughtPreviewsDataAccessable: DataManager {
    func getPreviews(completion: () -> ())
}

// single SubThought
protocol SubThoughtAccessable: DataManager {
    func subThoughtWithID(_ id: String)
}

// new SubThought
protocol SubThoughtCreatorAccessable: DataManager {
    func create(note: String?, image: UIImage?, link: String?)
}
