
protocol ExploreDelegate: Controller {
    
    var recentThoughts: [ThoughtPreview] { get }
    var orbits: [Orbit] { get }
    var stats: [BasicStatInfo] { get }
    func showOrbit( atIndex index: Int)
    func showThought(atIndex index: Int)
    func showInfoButton()
    
}
