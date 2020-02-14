import UIKit

protocol NewThoughtFlow: Coordinator {
    func createThought(_ title: String, orbits: [Orbit])
}
