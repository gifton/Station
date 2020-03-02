
// delegate for handling new subTHoughts
protocol NewSubThoughtFlow: Coordinator {
    func createSubThought(ofType type: SubThoughtType, completion: () -> ())
}
