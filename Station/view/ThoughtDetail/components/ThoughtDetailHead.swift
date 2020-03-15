import  UIKit


class ThoughtDetailHead: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
    }
    
    var delegate: ThoughtDetailHeadDelegate? {
        didSet {
            setView()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var card: ThoughtDetailHeadCard!
    var similarTHoughtsButton = UILabel.body("See similar Thoughts", .medium)
    
}


private extension ThoughtDetailHead {
    
    func setView() {
        backgroundView = .init(withColor: Colors.offWhite)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        card = ThoughtDetailHeadCard(title: delegate?.thought.title ?? "Not available", date: delegate?.thought.date ?? Date(), point: .init(Styles.Padding.xLarge.rawValue))
        
        addSubview(card)
        
        addSubview(similarTHoughtsButton)
        similarTHoughtsButton.sizeToFit()
        similarTHoughtsButton.top = card.bottom.addPadding()
        similarTHoughtsButton.center.x = Device.width / 2
        similarTHoughtsButton.textColor =  Colors.accentBlue
        
    }
    
    
}
