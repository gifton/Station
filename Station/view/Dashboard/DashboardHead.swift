
import UIKit

class DashboardHead: UIView {
    init(point: CGPoint) {
        super.init(frame: CGRect(origin: point, size: .init(Device.width, 245)))
    
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var welcomeLabel = UILabel.titleLabel(nil, .xXLarge)
    private var infoButton = UIImageView(image: UIImage(color: Styles.Colors.primaryBlue))
    private var logo = UILabel.titleLabel("Station", .max)
    private var dashboardImage = UIImageView(image: UIImage(color: Styles.Colors.primaryBlue))
}


private extension DashboardHead {
    func setView() {
        backgroundColor = .white
        layer.masksToBounds = true
        
        addSubview(logo)
        addSubview(welcomeLabel)
        addSubview(dashboardImage)
        addSubview(infoButton)
        
        // logo
        logo.sizeToFit()
        logo.left = Styles.Padding.xLarge.rawValue
        logo.top = 80
        logo.textColor = Styles.Colors.black
        
        // welcomeLabel
        
        let greetingBase = NSAttributedString(string: String.timeSensativeGreeting())
        let timeGreeting = NSMutableAttributedString(attributedString: greetingBase)
        timeGreeting.addAttributes([NSAttributedString.Key.foregroundColor: Styles.Colors.secondaryGray], range: (greetingBase.string as NSString).range(of: greetingBase.string))
        let greetingName = NSAttributedString(string: ",\nGifton")
        let name = NSMutableAttributedString(attributedString: greetingName)
        name.addAttributes([NSAttributedString.Key.foregroundColor: Styles.Colors.primaryBlue], range: (greetingName.string as NSString).range(of: greetingName.string))
        let greeting = NSMutableAttributedString()
        greeting.append(timeGreeting)
        greeting.append(name)
        
        
        welcomeLabel.attributedText = greeting
        welcomeLabel.numberOfLines = 2
        welcomeLabel.sizeToFit()
        welcomeLabel.left = Styles.Padding.xLarge.rawValue
        welcomeLabel.top = logo.bottom + Styles.Padding.medium.rawValue
        
        // dashboardImage
        dashboardImage.frame.size = .init(200, 162)
        dashboardImage.right = right - Styles.Padding.small.rawValue
        dashboardImage.top = 55
        
        // infoButton
        infoButton.frame.size = .init(35)
        infoButton.left = Styles.Padding.xLarge.rawValue
        infoButton.top = welcomeLabel.bottom + Styles.Padding.medium.rawValue
        
    }
}
