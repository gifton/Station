import UIKit

// MARk: TableView register/dequeuing methods
public extension UITableView {
    
    // register cell
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
    
    // - Returns: UICollectionViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(String(describing: name))")
        }
        return cell
    }
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(cellWithClass name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    func dequeueReusableHeader<T: UITableViewHeaderFooterView>(cellWithClassName name: T.Type) -> T {
        guard let head = dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldnt identify header with cell name: \(name)")
        }
        
        return head
    }
    
    // table header size to fit
    func tableHeaderViewSizeToFit() {
        tableHeaderOrFooterViewSizeToFit(\.tableHeaderView)
    }

    
    // table footer size to fit
    func tableFooterViewSizeToFit() {
        tableHeaderOrFooterViewSizeToFit(\.tableFooterView)
    }

    // size to fit internal func
    private func tableHeaderOrFooterViewSizeToFit(_ keyPath: ReferenceWritableKeyPath<UITableView, UIView?>) {
        guard let headerOrFooterView = self[keyPath: keyPath] else { return }
        let height = headerOrFooterView
            .systemLayoutSizeFitting(CGSize(width: frame.width, height: 0),
                                     withHorizontalFittingPriority: .required,
                                     verticalFittingPriority: .fittingSizeLevel).height
        
        guard headerOrFooterView.frame.height != height else { return }
        headerOrFooterView.frame.size.height = height
        self[keyPath: keyPath] = headerOrFooterView
    }

    // selected row
    func deselectSelectedRow(animated: Bool) {
        guard let indexPathForSelectedRow = indexPathForSelectedRow else { return }
        deselectRow(at: indexPathForSelectedRow, animated: animated)
    }

    // reload data helper method
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}
