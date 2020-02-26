
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
        setBottomView()
    }
    
    private var detailDelegate: ThoughtDetailDelegate
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // oh my god this is so many objects
    // top page
    private var thoughtTitle = UILabel()
    private var iconList: MicroOrbitView!
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
        iconList = MicroOrbitView(withDelegate: self, point: .init(x: Styles.Padding.xLarge.rawValue, y: 60))
        addSubview(iconList)
        
        // thoughttitle
        thoughtTitle.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        thoughtTitle.text = detailDelegate.thought.title
        thoughtTitle.setShadow(color: Styles.Colors.primaryGreen, opacity: 1.0, offset: .init(0), radius: 9, viewCornerRadius: 4)
        thoughtTitle.textColor = Styles.Colors.white
        thoughtTitle.font = Styles.Font.title(ofSize: .xXLarge)
        thoughtTitle.width = width - (25 + 70)
        thoughtTitle.height = 90
        thoughtTitle.backgroundColor =  Styles.Colors.primaryGreen
        thoughtTitle.layer.cornerRadius = 8
//        thoughtTitle.layer.masksToBounds = true
        thoughtTitle.numberOfLines = 2
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
        continueTheThought.top = thoughtDate.bottom.addPadding(.xXLarge, multiplier: 2)
        continueTheThought.left = left.addPadding(.xLarge)
        addSubview(continueTheThought)
        
        // icons
        let iconStack  = UIStackView(arrangedSubviews: [noteIcon, linkIcon, photoIcon], axis: .horizontal, spacing: 10, alignment: .fill, distribution: .fillEqually)
        iconStack.frame = CGRect(x: continueTheThought.left, y: continueTheThought.bottom.addPadding(.small), width: (noteIcon.width.addPadding(.medium)) * 3, height: 95)
        addSubview(iconStack)
        
        subThoughtIndicator.backgroundColor = Styles.Colors.primaryBlue
        subThoughtIndicator.frame = CGRect(x: 0, y: height - 70, width: width, height: 70)
        addSubview(subThoughtIndicator)
        
        // directionLabel
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
        
        setTopTargets()
    }
    
    // add delegate  targets
    func setTopTargets() {
        noteIcon.addTapGestureRecognizer(action: detailDelegate.newNote)
        linkIcon.addTapGestureRecognizer(action: detailDelegate.newLink)
        photoIcon.addTapGestureRecognizer(action: detailDelegate.newPhoto)
    }
}

// MARK: bottom  view setting
private extension ThoughtDetailView {
    func setBottomView() {
        tv = UITableView(frame: .init(x: 0, y: (contentSize.height / 2), width: width, height: height), style: .insetGrouped)
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundView = .init(withColor: .blue)
        addSubview(tv)
        print(tv.frame)
    }
    
    func setBottomTargets() {
        
    }
}


extension ThoughtDetailView: MicroOrbitDelegate {
    var orbits: [Orbit] {
        detailDelegate.thought.orbits
    }
    
    func didSelectOrbit(_ orbit: Orbit) {
        print("showing orbit in view")
    }
    
    func addNewOrbit() {
        print("showiinig new orbit view")
    }
    
    
}

extension ThoughtDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
extension ThoughtDetailView: UITableViewDelegate {
    
}
