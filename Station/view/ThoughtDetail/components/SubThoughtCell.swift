
import Kingfisher
import UIKit

final class SubThoughtCell:  UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundView = .init(withColor: Colors.softBG)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var preview: SubThoughtPreview?
    var typeIcon: UIImageView!
    let date = UILabel.mediumTitle("", .medium)
    let icon = UIImageView()
    let title = UILabel.body()
    
    func set(withPreview preview: SubThoughtPreview) {
        self.preview = preview
        
        setLowerContent()
        
        switch preview.type {
        case .note: setNoteView()
        case .link: setLinkView()
        case .image: setImageView()
        }
    }
    
    deinit {
        preview = nil
        typeIcon = nil
        date.text = ""
        icon.image = nil
        title.text = ""
    }
    
}

private extension SubThoughtCell {
    
    func setLowerContent() {
        
        
        if let preview = preview {
            
            switch preview.type {
            case .link: typeIcon = Icons.iconView(withImageType: .link, size: .xSmall, color: .black)
            case .image: typeIcon = Icons.iconView(withImageType: .camera, size: .xSmall, color: .black)
            case .note: typeIcon = Icons.iconView(withImageType: .note, size: .xSmall, color: .black)
            }
            
            typeIcon.left = left.addPadding()
            typeIcon.bottom = bounds.bottom.subtractPadding(.medium)
            addSubview(typeIcon)
            
            date.getStringFromDate(date: preview.date, withStyle: .long)
            date.sizeToFit()
            date.left = typeIcon.right.addPadding()
            date.bottom = bounds.bottom.subtractPadding(.medium)
            
            addSubview(date)
        }
    }
    func setNoteView() {
        
        let body = UILabel.body()
        
        if let preview = preview {
            
            body.text = preview.note
            body.numberOfLines = 0
            body.frame.origin = .init(Styles.Padding.large.rawValue)
            body.width = bounds.width.subtractPadding(.large, multiplier: 2)
            body.sizeToFit()
            addSubview(body)
            
        }
        
    }
    
    func setLinkView() {
        if let preview = preview, let linkIcon = preview.linkIcon, let link = preview.link {
            title.text = link
            
            icon.setImageWith(link: URL(string: linkIcon))
            icon.frame = CGRect(origin: .init(15), size: .init(25))
            
            icon.backgroundColor = .blue
            
            title.sizeToFit()
            title.left = icon.right.addPadding()
            title.center.y = icon.center.y
            
            addSubview(icon)
            addSubview(title)
            
            
        }
        
    }
    
    func setImageView() {
        let imageView = UIImageView()
        if let preview = preview, let img = preview.image {
            imageView.image = img
            if let imgSize = img.scaled(toWidth: bounds.width)?.size {
                imageView.frame = .init(x: 0, y: 0, width: width, height: imgSize.height)
                addSubview(imageView)
            }
        }
        
    }
}
