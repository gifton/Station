
import Foundation

protocol ThoughtDetailHeadDelegate: Controller {
    var thought: ThoughtPreview { get }
}

protocol CreateSubThoughtDelegate: Controller {
    func newPhoto()
    func newLink()
    func newNote()
}

protocol ThoughtDetailOrbitCellDelegate: Controller {
    func selectedOrbit(atIndex index: Int)
    func joinNewOrbit()
    var orbits: [Orbit] { get }
}


protocol ThoughtDetailDelegate: Controller {
    func newPhoto(completion: () -> ())
    func newLink(completion: () -> ())
    func newNote(completion: () -> ())
    func selectedOrbit(_ orbit: Orbit)
    func setNewOrbit()
    var thought: ThoughtPreview { get }
    
}
