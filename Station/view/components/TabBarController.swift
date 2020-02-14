
import UIKit


// MARK: TabBarController
// custom tab bar  for insetting images, and optional titles
final class TabBarController: UITabBarController {

    // helper method for setting icon images
    public func setIconImages(titles: [String]) {
        guard let items = self.tabBar.items else { return }
        
        for (index, element) in items.enumerated() {
            
            if let image = UIImage(named: titles[index]) {
                element.image = image.scaled(toHeight: 24)
            } else { print("nooooo")}
            
        }
    }
    
    public func setTitles(titles: [String]) {
        guard let items = self.tabBar.items else { return }
        
        for (index, element) in items.enumerated() {
            element.title = titles[index]
        }
    }
    
    // inset icons downwards 10px
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let items = tabBar.items else { return }
        tabBar.itemPositioning = .automatic
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: Styles.Padding.medium.rawValue, left: 0, bottom: -1 * Styles.Padding.medium.rawValue, right: 0)
        }
        
        tabBar.items?.forEach {
            // add (-) of top inset padding to keep current aspect / size
            $0.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
            
        }
    }
    
}
