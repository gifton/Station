
import UIKit



class ThoughtDetailView: UIScrollView {
    init(withDelegate: ThoughtDetailDelegate) {
        detailDelegate = withDelegate
        super.init(frame: CGRect(x: 0, y: 80, width: Device.width, height: Device.height - 80))
        contentSize = .init(Device.width, height * 2)
        backgroundColor =  .white
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        
        let bottomView = UIView(withColor: Colors.offWhite)
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
    private var subThoughtCountWeek = UILabel.body()
    private var subThoughtAllTime = UILabel.body()
    private var thoughtDate = UILabel.body()
    private var subThoughtCountIcon = UILabel.mediumTitle()
    private var continueTheThought = UILabel.mediumTitle("Continue the thought", .large)
    private var noteIcon = SubThoughtTypeButton(type: .note)
    private var linkIcon = SubThoughtTypeButton(type: .link)
    private var photoIcon = SubThoughtTypeButton(type: .image)
    private var subThoughtIndicator = UIView()
    // bottom page
    private var tv: UITableView!
    
    public func needsRefresh() {
        tv.reloadData()
    }
}


// MARK: Top  view setting
// larger screens require me to break  down methods into more steps for readability
private extension ThoughtDetailView {
    
    // add delegate content to objects
    func setContent() {
        
        // thoughtitle
        thoughtTitle.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 10)
        thoughtTitle.text = detailDelegate.thought.title
        thoughtTitle.textColor = Colors.white
        thoughtTitle.font = Styles.Font.title(ofSize: .xXLarge)
        thoughtTitle.width = width - (25 + 70)
        thoughtTitle.height = 90
        thoughtTitle.numberOfLines = 2
        thoughtTitle.top = safeAreaInsets.bottom.addPadding(.xXLarge, multiplier: 2)
        thoughtTitle.left = left.addPadding(.xLarge)
        
        let thoughtMask = UIView(frame: thoughtTitle.frame)
        thoughtMask.backgroundColor = Colors.primaryBlue
        thoughtMask.layer.cornerRadius = 8
        thoughtMask.setShadow(color: Colors.primaryBlue, opacity: 1.0, offset: nil, radius: 5, viewCornerRadius: 8)
        addSubview(thoughtMask)
        addSubview(thoughtTitle)
        
        // subThoughtCounts
        subThoughtCountWeek.text = String(describing: detailDelegate.thought.subThoughtsInTheLastWeek) + " Sub Thoughts this week"
        subThoughtAllTime.text = String(describing: detailDelegate.thought.subThoughts.count) + " Total Sub Thought"
        subThoughtCountWeek.textColor = Colors.secondaryGray
        subThoughtAllTime.textColor = Colors.secondaryGray
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
        
        // iconlist
        iconList = MicroOrbitView(withDelegate: self, point: .init(x: Styles.Padding.xLarge.rawValue, y: iconStack.bottom.addPadding(.xLarge, multiplier: 2)))
        addSubview(iconList)
        
        
        subThoughtIndicator.backgroundColor = Colors.primaryBlue
        subThoughtIndicator.frame = CGRect(x: 0, y: height - 70, width: width, height: 70)
        addSubview(subThoughtIndicator)
        
        // directionLabel
        let dirLabel = UILabel.body("Sub Thoughts ", .medium)
        dirLabel.textColor = Colors.white
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
        subThoughtIndicator.addTapGestureRecognizer { self.setContentOffset(.init(0, Device.height - Device.tabBarheight), animated: true) }
        
        setTopTargets()
    }
    
    // add delegate  targets
    func setTopTargets() {
        noteIcon.addTapGestureRecognizer {
            self.detailDelegate.newNote {
                self.tv.reloadData()
            }
        }
        linkIcon.addTapGestureRecognizer {
            self.detailDelegate.newLink {
                self.tv.reloadData()
            }
        }
        photoIcon.addTapGestureRecognizer {
            self.detailDelegate.newPhoto {
                self.tv.reloadData()
            }
        }
    }
}

// MARK: bottom  view setting
private extension ThoughtDetailView {
    func setBottomView() {
        tv = UITableView(frame: .init(x: 0, y: (contentSize.height / 2), width: width, height: height), style: .insetGrouped)
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundView = .init(withColor: .white)
        tv.register(cellWithClass: SubThoughtCell.self)
        addSubview(tv)
    }  
}


extension ThoughtDetailView: MicroOrbitDelegate {
    var orbits: [Orbit] {
        detailDelegate.thought.orbits
    }
    
    func didSelectOrbit(_ orbit: Orbit) {
        detailDelegate.selectedOrbit(orbit)
    }
    
    func addNewOrbit() {
        detailDelegate.setNewOrbit()
    }
    
    
}

extension ThoughtDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailDelegate.thought.subThoughts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: SubThoughtCell.self, for: indexPath)
        cell.set(withPreview: SubThoughtPreview.fromCoreObject(detailDelegate.thought.subThoughts[indexPath.row]))
        return cell
    }
    
    
}
extension ThoughtDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sb = detailDelegate.thought.subThoughts[indexPath.row]
        switch sb.subThoughtType {
        case .note:
            if let note = sb.note {
                let height = note.minimumHeightForDisplay( font: Styles.Font.body(), width: Device.width.subtractPadding(.xXLarge, multiplier: 2) )
                
                return height + 60
            }; return 100
            
        case .image: return 150
        case .link: return 90
        }
    }
}
