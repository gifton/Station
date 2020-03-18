
protocol NewThoughtViewDelegate: AnyObject {

    func save(withTitle title: String, andOrbits orbits: [Orbit])
    func save(withTitle title: String, andIcon icon: String)
    func filterOrbits(withPredicate pred: String)
    var orbits: [Orbit] { get }
    
}
