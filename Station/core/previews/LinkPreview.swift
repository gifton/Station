
import Foundation
import SwiftLinkPreview

struct LinkPreview {
    var link: String
    var title: String
    var iconURL: String
    var description: String
    
    init(_ slp: Response) {
        link = String(describing: slp.url)
        title = slp.title ?? "No Title"
        iconURL = slp.icon ?? "no icon"
        description =  slp.description ?? "No description"
    }
}
