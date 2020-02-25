
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
    func newPhoto()
    func newLink()
    func newNote()
    var thought: ThoughtPreview { get }
}
