

protocol NewSubThought: Coordinator {
    func createSubThought(for thought: Thought, ofType type: SubThoughtType)
}
