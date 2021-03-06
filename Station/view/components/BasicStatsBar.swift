
import UIKit


enum BasicStatsType: String {
    
    case thought = "Thoughts"
    case subThought = "Entries"
    case orbits = "Orbits"
    
}

struct BasicStatInfo {
    var statType: BasicStatsType
    var weekCount: Int
    var monthCount: Int
}


final class BasicStatsBar: UIView {
    
    init(point: CGPoint, info: BasicStatInfo, withTitle title: Bool = false) {
        self.statType = info.statType
        weekCount = info.weekCount
        monthCount = info.monthCount
        
        if (title == true) {
            titleLabel = UILabel.body("Stats", .medium)
            super.init(frame: .init(origin: point, size: CGSize(width: 315, height: 85)))
        } else {
            super.init(frame: .init(origin: point, size: CGSize(width: 290, height: 85)))
        }
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var weekCount: Int
    var monthCount: Int
    
    var titleLabel: UILabel?
    var statType: BasicStatsType
    var icon = UIImageView(image: Icons.iconForType(.thought))
    var weekLabel = UILabel.lightBody()
    var monthLabel = UILabel.lightBody()
    var weekCountLabel = UILabel.title()
    var monthCountLabel = UILabel.title()
    
}

private extension BasicStatsBar {
    
    func setView() {
        
        // set title
        if (titleLabel != nil) {
            titleLabel?.sizeToFit()
            titleLabel?.frame.origin = .zero
            titleLabel?.textColor = Colors.secondaryGray
            titleLabel?.left += 5
            addSubview(titleLabel!)
        }
        
        // set cell
        let cell = UIView(frame: CGRect(x: 0, y: titleLabel?.bottom.addPadding(.small) ?? 0, width: width, height: height - (titleLabel?.height ?? 0)))
        cell.layer.cornerRadius = 18
        cell.layer.masksToBounds = true
        cell.layer.borderColor = Colors.lightGray.cgColor
        cell.layer.borderWidth = 2
        
        addSubview(cell)
        
        // set cell content
        cell.addSubview(icon)
        icon.frame.size = CGSize(35, 25)
        icon.left = Styles.Padding.large.rawValue
        icon.center.y = cell.height / 2
        icon.tintColor = Colors.primaryBlue
        
        weekLabel.text = "\(statType) this week"
        monthLabel.text = "\(statType) this month"
        weekLabel.textColor = Colors.darkGray
        monthLabel.textColor = Colors.darkGray
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
        
        weekCountLabel.textColor = Colors.primaryBlue
        monthCountLabel.textColor = Colors.primaryBlue
        weekCountLabel.text = String(describing: weekCount)
        monthCountLabel.text = String(describing: monthCount)
        weekCountLabel.sizeToFit()
        monthCountLabel.sizeToFit()
        
        let countStack = UIStackView(arrangedSubviews: [weekCountLabel, monthCountLabel], axis: .vertical, spacing: 5, alignment: .leading, distribution: .fillEqually)
        countStack.frame.size = CGSize(max(weekCountLabel.width, monthCountLabel.width), (monthCountLabel.height * 2) + 5)
        countStack.right = cell.right.subtractPadding(.xLarge)
        countStack.centerY = cell.centerY
        
        addSubview(countStack)
        
    }
}
