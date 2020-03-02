
import Foundation

// MARK: className protocol for dequeing cells from UITableView/UICollectionView generically
// allows for registering / accessin cells withought having to define reuseIdentifiers
public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}
// MARK: classname helper variables
public extension ClassNameProtocol {
    static var className: String {
        String(describing: self)
    }

    var className: String {
        Self.className
    }
}

// conform NSObects to Classname protocol (requires no arguments)
extension NSObject: ClassNameProtocol {}

// TODO: rewrite in readable form
public extension NSObjectProtocol {
    var propertyDescription: String {
        let mirror = Mirror(reflecting: self)
        return mirror.children.map { element -> String in
            let key = element.label ?? "Unknown"
            let value = element.value
            return "\(key): \(value)"
            }
            .joined(separator: "\n")
    }
}
