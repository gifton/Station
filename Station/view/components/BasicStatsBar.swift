
import UIKit


enum BasicStatsType: String {
    
    case though = "Thoughts"
    case subThought = "Entries"
    case orbits = "Orbits"
    
}


class BasicStatsBar: UIView {
    
    init(point: CGPoint, type: BasicStatsType, withTitle title: Bool = false) {
        self.statType = type
        
        if (title == true) {
            titleLabel = UILabel.bodyLabel("Stats", .medium)
            super.init(frame: .init(origin: point, size: CGSize(width: 315, height: 85)))
        } else {
            super.init(frame: .init(origin: point, size: CGSize(width: 290, height: 85)))
        }
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLabel: UILabel?
    var statType: BasicStatsType
    var icon = UIImageView(image: UIImage(color: Styles.Colors.darkGray))
    var weekLabel = UILabel.lightBodyLabel()
    var monthLabel = UILabel.lightBodyLabel()
    var weekCountLabel = UILabel.titleLabel()
    var monthCountLabel = UILabel.titleLabel()
    
}


private extension BasicStatsBar {
    func setView() {
        
        // set title
        if (titleLabel != nil) {
            titleLabel?.sizeToFit()
            titleLabel?.frame.origin = .zero
            titleLabel?.textColor = Styles.Colors.secondaryGray
            titleLabel?.left += 5
            addSubview(titleLabel!)
        }
        
        // set cell
        let cell = UIView(frame: CGRect(x: 0, y: titleLabel?.bottom ?? 0, width: width, height: height - (titleLabel?.height ?? 0)))
        cell.layer.cornerRadius = 18
        cell.layer.masksToBounds = true
        cell.layer.borderColor = Styles.Colors.darkGray.cgColor
        cell.layer.borderWidth = 0.5
        
        addSubview(cell)
        
        // set cell content
        cell.addSubview(icon)
        icon.frame.size = CGSize(35, 25)
        icon.left = Styles.Padding.large.rawValue
        icon.center.y = cell.height / 2
        
        weekLabel.text = "\(statType) this week"
        monthLabel.text = "\(statType) this month"
        weekLabel.textColor = Styles.Colors.darkGray
        monthLabel.textColor = Styles.Colors.darkGray
        weekLabel.sizeToFit()
        monthLabel.sizeToFit()
        
        
        let labelStack = UIStackView(arrangedSubviews: [weekLabel, monthLabel], axis: .vertical, spacing: 5, alignment: .leading, distribution: .fillEqually)
        labelStack.layer.backgroundColor = UIColor.red.cgColor
        labelStack.frame.size = CGSize(monthLabel.width, (weekLabel.height * 2) + 5)
        labelStack.centerX = cell.centerX
        labelStack.centerY = cell.centerY
        
        // if you add this labelStack to its appropriate cell, centering doesnt work
        // only our lord and savior elon musk knows why this doesnt workn in the child cell, however it works fine, so pls dont touch.
        addSubview(labelStack)
        
        weekCountLabel.textColor = Styles.Colors.primaryBlue
        monthCountLabel.textColor = Styles.Colors.primaryBlue
        weekCountLabel.text = "12"
        monthCountLabel.text = "55"
        weekCountLabel.sizeToFit()
        monthCountLabel.sizeToFit()
        
        let countStack = UIStackView(arrangedSubviews: [weekCountLabel, monthCountLabel], axis: .vertical, spacing: 5, alignment: .leading, distribution: .fillEqually)
        countStack.frame.size = CGSize(max(weekCountLabel.width, monthCountLabel.width), (monthCountLabel.height * 2) + 5)
        countStack.right = cell.right - Styles.Padding.xLarge.rawValue
        countStack.centerY = cell.centerY
        
        addSubview(countStack)
        
        print(countStack.frame)
    }
}
