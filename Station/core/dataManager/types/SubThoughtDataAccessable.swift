
protocol SubThoughtDataAccessable: DataManager {
    func createSubThought(ofType type: SubThoughtType, withPreview preview: SubThoughtPreview)
}
