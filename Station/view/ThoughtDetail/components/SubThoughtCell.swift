
import UIKit

class SubThoughtCell:  UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundView = .init(withColor: Colors.softBG)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var preview: SubThoughtPreview?
    
    func set(withPreview preview: SubThoughtPreview) {
        self.preview = preview
        
        setLowerContent()
        
        switch preview.type {
        case .note: setNoteView()
        case .link: setLinkView()
        case .image: setImageView()
        }
    }
    
    override func prepareForReuse() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}

private extension SubThoughtCell {
    
    func setLowerContent() {
        let date = UILabel.mediumTitle("", .medium)
        let typeIcon: UIImageView!
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
        
    }
    
    func setImageView() {
        
    }
}
