import Foundation

// delegate for handling creation of new thought
protocol NewThoughtFlow: Coordinator {
    func createThought(_ title: String, orbits: [Orbit])
}
