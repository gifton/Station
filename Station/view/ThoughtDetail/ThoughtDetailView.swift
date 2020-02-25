
import UIKit



class ThoughtDetailView: UIScrollView {
    init(withDelegate: ThoughtDetailDelegate) {
        detailDelegate = withDelegate
        super.init(frame: CGRect(x: 0, y: 80, width: Device.width, height: Device.height - 80))
        contentSize = .init(Device.width, height * 2)
        backgroundColor =  .white
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        
        let bottomView = UIView(withColor: Styles.Colors.offWhite)
        bottomView.frame = CGRect(x: 0, y: height, width: width, height: height)
        addSubview(bottomView)
        setContent()
    }
    
    private var detailDelegate: ThoughtDetailDelegate
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // oh my god this is so many objects
    // top page
    private var thoughtTitle = UILabel.titleLabel()
    private var iconList = UIView(withColor: Styles.Colors.primaryBlue)
    private var subThoughtCountWeek = UILabel.bodyLabel()
    private var subThoughtAllTime = UILabel.bodyLabel()
    private var thoughtDate = UILabel.bodyLabel()
    private var subThoughtCountIcon = UILabel.mediumTitleLabel()
    private var continueTheThought = UILabel.mediumTitleLabel("Continue the thought", .large)
    private var noteIcon = SubThoughtIcon(type: .note)
    private var linkIcon = SubThoughtIcon(type: .link)
    private var photoIcon = SubThoughtIcon(type: .image)
    private var subThoughtIndicator = UIView()
    // bottom page
    private var tv: UITableView!
    
    
}


// MARK: Top  view setting
// larger screens require me to break  down methods into more steps for readability
private extension ThoughtDetailView {
    
    // add delegate content to objects
    func setContent() {
        
        // iconlist
        iconList.frame = CGRect(x: Styles.Padding.xLarge.rawValue, y: 100, width: width.subtractPadding(.xLarge, multiplier: 2), height: 36)
        addSubview(iconList)
        
        // thoughttitle
        thoughtTitle.text = detailDelegate.thought.title
        thoughtTitle.width = width.subtractPadding(.xLarge) - 35
        thoughtTitle.height = thoughtTitle.minimumHeight(forWidth: width.subtractPadding(.xLarge) - 35)
        thoughtTitle.textColor = .black
        thoughtTitle.numberOfLines = 0
        thoughtTitle.top = iconList.bottom.addPadding(.xXLarge, multiplier: 2)
        thoughtTitle.left = left.addPadding(.xLarge)
        addSubview(thoughtTitle)
        
        // subThoughtCounts
        subThoughtCountWeek.text = String(describing: detailDelegate.thought.subThoughtsInTheLastWeek) + " Sub Thoughts this week"
        subThoughtAllTime.text = String(describing: detailDelegate.thought.subThoughts.count) + " Total Sub Thought"
        subThoughtCountWeek.textColor = Styles.Colors.secondaryGray
        subThoughtAllTime.textColor = Styles.Colors.secondaryGray
        subThoughtAllTime.sizeToFit()
        subThoughtCountWeek.sizeToFit()
        let stack = UIStackView(arrangedSubviews: [subThoughtCountWeek, subThoughtAllTime], axis: .vertical, spacing: 5, alignment: .leading, distribution: .fill)
        stack.frame = CGRect(x: thoughtTitle.left, y: thoughtTitle.bottom.addPadding(.xLarge, multiplier: 3), width: width / 2, height: (subThoughtAllTime.height * 2) + 5)
        addSubview(stack)
        
        // thoughtDate
        thoughtDate.getStringFromDate(date: detailDelegate.thought.date, withStyle: .medium)
        thoughtDate.text = "created on " + thoughtDate.text!
        thoughtDate.sizeToFit()
        thoughtDate.top = stack.bottom.addPadding()
        thoughtDate.left = left.addPadding(.xLarge)
        addSubview(thoughtDate)
        
        //continue the thought
        continueTheThought.sizeToFit()
        continueTheThought.top = thoughtDate.bottom.addPadding(.xLarge, multiplier: 2)
        continueTheThought.left = left.addPadding(.xLarge)
        addSubview(continueTheThought)
        
        // icons
        let iconStack  = UIStackView(arrangedSubviews: [noteIcon, linkIcon, photoIcon], axis: .horizontal, spacing: 10, alignment: .fill, distribution: .fillEqually)
        iconStack.frame = CGRect(x: continueTheThought.left, y: continueTheThought.bottom.addPadding(.small), width: (noteIcon.width.addPadding(.medium)) * 3, height: 95)
        addSubview(iconStack)
        
        subThoughtIndicator.backgroundColor = Styles.Colors.primaryBlue
        subThoughtIndicator.frame = CGRect(x: 0, y: height - 70, width: width, height: 70)
        addSubview(subThoughtIndicator)
        
        let dirLabel = UILabel.bodyLabel("Sub Thoughts ", .medium)
        dirLabel.textColor = Styles.Colors.white
        dirLabel.sizeToFit()
        
        let dirImage = UIImageView(image: Icons.iconForType(.arrow)!
        .scaled(toHeight: 20.0)?
        .rotate(radians: -1 * (.pi / 2))
        .tintImage(toColor: .white))
        
        
        let dirStack = UIStackView(arrangedSubviews: [dirLabel, dirImage], axis: .horizontal, spacing: 2, alignment: .center, distribution: .fillProportionally)
        dirStack.frame.size = .init(dirLabel.width + dirImage.width + 2, 25)
        dirStack.top = Styles.Padding.large.rawValue
        dirStack.center.x = width / 2
        subThoughtIndicator.addSubview(dirStack)
    }
    
    // set frames styling  etc
    func setTopView() {
        
    }
    
    // add delegate  targets
    func setTopTargets() {
        
    }
}

// MARK: bottom  view setting
private extension ThoughtDetailView {
    func setBottomView() {
        
    }
    
    func setBottomTargets() {
        
    }
}
