
// delegate for dislaying single thought content
protocol ThoughtDetailFlow: Coordinator {
    func showThought(_ thought: Thought)
}
