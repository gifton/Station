

protocol NewSubThoughtFlow: Coordinator {
    func createSubThought(for thought: Thought, ofType type: SubThoughtType, completion: () -> ())
}
