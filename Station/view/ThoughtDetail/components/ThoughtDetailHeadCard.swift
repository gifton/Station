
import UIKit


class ThoughtDetailHeadCard: UIView {
    init(title: String, date: Date, point: CGPoint) {
        self.title = title
        self.date = date
        super.init(frame: CGRect(origin: point, size: .init(Device.width.subtractPadding(.xLarge, multiplier: 2), 100)))
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: String
    var date: Date
}


private extension ThoughtDetailHeadCard {
    
    func setView() {
        
        layer.cornerRadius = 10
        backgroundColor = Colors.primaryGreen
        setShadow(color: backgroundColor!, opacity: 1.0, offset: .init(0), radius: 9, viewCornerRadius: 4)
        
        let styleLine = UIView(withColor: Colors.secondaryGreen)
        addSubview(styleLine)
        styleLine.frame.size = .init(250, 2)
        styleLine.frame.origin = .zero
        styleLine.center.y = height / 2
        styleLine.center.x = width / 2
        styleLine.layer.cornerRadius = 1
        
        let titleLabel = UILabel.body(title, .large)
        titleLabel.textColor = .white

        let dateLabel = UILabel.title("", .medium)
        dateLabel.getStringFromDate(date: date, withStyle: .long)
        dateLabel.textColor = UIColor.white.withAlphaComponent(0.65)
        
        addSubview(titleLabel)
        addSubview(dateLabel)
        
        titleLabel.sizeToFit()
        dateLabel.sizeToFit()
        
        titleLabel.bottom = styleLine.top.subtractPadding(.small)
        dateLabel.top = styleLine.bottom.addPadding(.small)
        
        titleLabel.center.x = width / 2
        dateLabel.center.x = width / 2
    }
}
