
// delegate for hanfling sub thoughts for a specific thought
protocol SubThoughtDetailFlow: Coordinator {
    func showSubThought(_ thought: Thought)
}
