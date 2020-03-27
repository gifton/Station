
// empty identifier for all rpeview objects
// preview bjects allow classes to create new User-creatable objects without the need to load entire ManagedObectContext into memory until necessary

protocol DataPreview {
    var previewType: PreviewType { get }
}

enum PreviewType: String {
    case link = "link",
    note = "note",
    image = "image",
    thought = "thought",
    topic = "topic"
}
