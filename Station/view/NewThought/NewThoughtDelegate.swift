
protocol NewThoughtViewDelegate {

    func newOrbit()
    func save(withTitle title: String, andOrbits orbits: [Orbit])
    var orbits: [Orbit] { get }
}
