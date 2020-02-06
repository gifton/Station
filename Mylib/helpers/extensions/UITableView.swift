import UIKit


public extension UITableView {
    
    // register cell
    func register(cellType: UITableViewCell.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    // register multiple cells
    func register(cellTypes: [UITableViewCell.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    // deqeue cell
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
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
