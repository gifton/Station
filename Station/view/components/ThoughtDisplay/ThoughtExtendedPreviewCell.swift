
import UIKit


class ThoughtExtendedPreviewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var thought: ThoughtPreview?
    
    private var orbits = UILabel.bodyLabel(nil, .xXLarge)
    private var dateLabel = UILabel.bodyLabel(nil, .small)
    private var subThoughts = UILabel.titleLabel(nil, .medium)
    private var title = UILabel.bodyLabel(nil, .large)
    
    
    public func set(withThought thought: ThoughtPreview) {
        self.thought = thought
        setView()
    }
}

private extension ThoughtExtendedPreviewCell {
    func setView() {
        guard let thought = thought else { return }
        
        addSubview(title)
        addSubview(dateLabel)
        addSubview(orbits)
        addSubview(subThoughts)
        // set content
        title.text = thought.title
        dateLabel.getStringFromDate(date: thought.date, withStyle: .medium)
        subThoughts.text = "29 Sub Thoughts"
        
        // orbits
        orbits.text = "🧘🏽‍♂️ 🛤 🍕 🎄"
        orbits.sizeToFit()
        orbits.preferredMaxLayoutWidth = 150
        orbits.left = left.addPadding(.xLarge)
        orbits.bottom = height - Styles.Padding.large.rawValue
        orbits.textDropShadow()
        
        // title
        title.numberOfLines = 3
        title.text = thought.title
        title.height = 75
        title.width = width.subtractPadding(multiplier: 2)
        title.left = Styles.Padding.medium.rawValue
        title.top = Styles.Padding.medium.rawValue
        title.layer.cornerRadius = 10
        title.layer.masksToBounds = true
        title.backgroundColor = Styles.Colors.offWhite
        title.textColor = Styles.Colors.darkGray
        title.padding = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 5)
        
        // date
        dateLabel.text = "March 3rd, 2020"
        dateLabel.sizeToFit()
        dateLabel.right = title.right
        dateLabel.top = title.bottom.addPadding(.medium) + 2 // center since text is smaller on right than left
        dateLabel.textColor = Styles.Colors.secondaryGray
        
        // subthought
        subThoughts.sizeToFit()
        subThoughts.textColor = Styles.Colors.primaryBlue
        subThoughts.top = title.bottom.addPadding(.medium)
        subThoughts.left = Styles.Padding.xLarge.rawValue
        
    }
}
