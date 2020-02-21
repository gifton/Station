
protocol ExplroeDelegate {
    var userGreeting: String { get }
    func selectedInfoButton()
    func selectedThought(_ thought: Thought)
    func selectedOrbit(_ orbit: Orbit)
    var stats: [BasicStatsType] { get }
}
