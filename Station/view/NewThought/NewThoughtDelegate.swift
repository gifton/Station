
protocol NewThoughtViewDelegate {

    func newOrbit()
    func save(withTitle title: String, andOrbits orbits: [Orbit])
    func filterOrbits(withPredicate pred: String)
    var orbits: [Orbit] { get }
}
