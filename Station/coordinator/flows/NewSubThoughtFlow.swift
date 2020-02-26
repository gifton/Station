

protocol NewSubThoughtFlow: Coordinator {
    func createSubThought(ofType type: SubThoughtType, completion: () -> ())
}
