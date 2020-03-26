

import UIKit
import Kingfisher

// image view is how images are placed on a screen in a view
extension UIImageView {
    
    
    // helper function takes in URL and checks cache for availablilty, if not previously saved, download, then set image
    // (link:) is used for images that are not auto resized (non-profile pictures for now)
    public func setImageWith(link: URL?) {
        if let url = link {
            // check if image is in cache already
            if ImageCache.default.isCached(forKey: url.absoluteString) {
                let resource = ImageResource(downloadURL: url, cacheKey: String(describing: link))
                kf.setImage(with: resource)
                
            } else {
                
                kf.indicatorType = .activity
                kf.setImage(with: link, options: [.transition(.fade(0.4))])
                
            }
        }
        
    }
    
}
