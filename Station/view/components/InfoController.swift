
import UIKit

enum InfoType: String {
    case general = "General"
    case orbit = "Orbits"
    case subThought = "Sub Thoughts"
    case thought = "Thoughts"
}

enum InfoDescription: String {
    case thought = "Thoughts are the fundamental building blocks of Station. \nYou'll use them to define a basic idea of what  you're thinking about. Tap the plus button in the tab bar below to start a new thought"
    case subThought = "Sub Thoughts help you continue your train of thought. They let you add pictures, links and pure text to a pre defined thought, and help relate continued ideas to that original thought to evolve and grow your understanding"
    case missionStatement = "Station aims to improve the way think by creating an simple and safe way to record what your thinking. More than a notes app, Station lets you catagorize your thoughts using a system called 'Orbits' and continue your thinking with 'Sub Thoughts'"
    case orbit = "Orbits help you catogarize and group thoughts.  Orbits relate thoughts with a keyword, like 'Self improvement' or 'Personal'"
    
}

final class InfoController: Controller {
    
    init(type: InfoType) {
        infoType = type
        super.init(nibName: nil, bundle: nil)
        
        buildHeaders()
        
        switch type {
        case .general: buildGeneralInfo()
        case .orbit: buildOrbitInfo()
        case .subThought: buildSubThoughtInfo()
        case .thought: buildThoughtInfo()
        }
        
        
    }
    
    var infoType: InfoType
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel = UILabel.title("Station", .max)
    let infoButton = Icons.iconView(withImageType: .info, size: .large)
    let typeLabel = UILabel.mediumTitle()
    let missionStatementTitle = UILabel.mediumTitle("Mission Statement", .xLarge)
    let missionStatement = UILabel.body(InfoDescription.missionStatement.rawValue, .large)
    let thoughtTitle = UILabel.mediumTitle("Thoughts")
    let subThoughtTitle = UILabel.mediumTitle("Sub Thoughts")
    let orbitTitle = UILabel.mediumTitle("Orbits")
    let thoughtDescription = UILabel.body(InfoDescription.thought.rawValue)
    let subThoughtDescription = UILabel.body(InfoDescription.subThought.rawValue)
    let orbitDescription = UILabel.body(InfoDescription.orbit.rawValue)
}


private  extension InfoController {
    
    func buildHeaders() {
        titleLabel.sizeToFit()
        infoButton.sizeToFit()
        
        view.addSubview(titleLabel)
        view.addSubview(infoButton)
        
        titleLabel.pin(onEdge: .left, withPadding: .large)
        titleLabel.pin(onEdge: .top, withPadding: .xLarge)
        
        infoButton.pin(onEdge: .right, withPadding: .large)
        infoButton.pin(onEdge: .top, withPadding: .xLarge)
        
        typeLabel.text =  infoType.rawValue
        typeLabel.sizeToFit()
        typeLabel.top = titleLabel.bottom.addPadding(.small)
        typeLabel.left = view.left.addPadding(.xLarge)
        view.addSubview(typeLabel)
        
        missionStatementTitle.sizeToFit()
        missionStatementTitle.underline()
        missionStatementTitle.top = typeLabel.bottom.addPadding(.xXLarge)
        missionStatementTitle.left = typeLabel.left
        view.addSubview(missionStatementTitle)
        
        missionStatement.numberOfLines = 0
        missionStatement.width = view.width.subtractPadding(.xLarge, multiplier: 2)
        missionStatement.sizeToFit()
        missionStatement.textColor = Colors.darkGray
        missionStatement.top = missionStatementTitle.bottom.addPadding(.medium)
        missionStatement.left = view.left.addPadding(.xLarge)
        view.addSubview(missionStatement)
    }
    
    func buildGeneralInfo() {
        let stack = UIStackView(
            arrangedSubviews: [
                Icons.iconView(withImageType: .thought, size: .large),
                Icons.iconView(withImageType: .subThought, size: .large),
                Icons.iconView(withImageType: .orbit, size: .large)
            ],
            axis: .horizontal,
            spacing: 5
        )
        stack.width = ((35 + 5) * 3)
        stack.height = 35
        
        let title = UILabel.title("Building Blocks", .xLarge)
        let description = UILabel.mediumTitle("Station employes three main objects to help you efficiantly record record and continue your thoughts", .large)
        description.width = view.width.subtractPadding(.xLarge, multiplier: 2)
        description.numberOfLines = 0
        title.sizeToFit()
        description.sizeToFit()
        
        title.top = missionStatement.bottom.addPadding(.xXLarge)
        title.left = missionStatement.left
        view.addSubview(title)
        
        description.left = title.left
        description.top = title.bottom.addPadding(.small)
        view.addSubview(description)
        
        stack.center.y = title.center.y
        stack.left = title.right.addPadding(.xLarge)
        view.addSubview(stack)
        
        thoughtTitle.sizeToFit()
        thoughtTitle.textColor = Colors.primaryBlue
        thoughtTitle.top = description.bottom.addPadding(.xXLarge)
        thoughtTitle.left = description.left
        view.addSubview(thoughtTitle)
        
        thoughtDescription.numberOfLines = 0
        thoughtDescription.width = view.width.subtractPadding(.xLarge, multiplier: 2)
        thoughtDescription.sizeToFit()
        thoughtDescription.top = thoughtTitle.bottom.addPadding(.small)
        thoughtDescription.left = thoughtTitle.left
        view.addSubview(thoughtDescription)
        
        subThoughtTitle.sizeToFit()
        subThoughtTitle.textColor = Colors.primaryBlue
        subThoughtTitle.left = description.left
        subThoughtTitle.top = thoughtDescription.bottom.addPadding()
        view.addSubview(subThoughtTitle)
        
        subThoughtDescription.numberOfLines = 0
        subThoughtDescription.width = view.width.subtractPadding(.xLarge, multiplier: 2)
        subThoughtDescription.sizeToFit()
        subThoughtDescription.top = subThoughtTitle.bottom.addPadding(.small)
        subThoughtDescription.left = subThoughtTitle.left
        view.addSubview(subThoughtDescription)
        
        orbitTitle.sizeToFit()
        orbitTitle.textColor = Colors.primaryBlue
        orbitTitle.left = description.left
        orbitTitle.top = subThoughtDescription.bottom.addPadding()
        view.addSubview(orbitTitle)
        
        orbitDescription.numberOfLines = 0
        orbitDescription.width = view.width.subtractPadding(.xLarge, multiplier: 2)
        orbitDescription.sizeToFit()
        orbitDescription.top = orbitTitle.bottom.addPadding(.small)
        orbitDescription.left = orbitTitle.left
        view.addSubview(orbitDescription)
        
    }
    
    func buildOrbitInfo() {
        orbitTitle.sizeToFit()
        orbitTitle.textColor = Colors.primaryBlue
        orbitTitle.left = missionStatement.left
        orbitTitle.top = missionStatement.bottom.addPadding()
        view.addSubview(orbitTitle)
        
        orbitDescription.numberOfLines = 0
        orbitDescription.width = view.width.subtractPadding(.xLarge, multiplier: 2)
        orbitDescription.sizeToFit()
        orbitDescription.top = orbitTitle.bottom.addPadding(.small)
        orbitDescription.left = orbitTitle.left
        view.addSubview(orbitDescription)
    }
    
    func buildSubThoughtInfo() {
        subThoughtTitle.sizeToFit()
        subThoughtTitle.textColor = Colors.primaryBlue
        subThoughtTitle.left = missionStatement.left
        subThoughtTitle.top = missionStatement.bottom.addPadding()
        view.addSubview(subThoughtTitle)
        
        subThoughtDescription.numberOfLines = 0
        subThoughtDescription.width = view.width.subtractPadding(.xLarge, multiplier: 2)
        subThoughtDescription.sizeToFit()
        subThoughtDescription.top = subThoughtTitle.bottom.addPadding(.small)
        subThoughtDescription.left = subThoughtTitle.left
        view.addSubview(subThoughtDescription)
    }
    
    func buildThoughtInfo() {
        thoughtTitle.sizeToFit()
        thoughtTitle.textColor = Colors.primaryBlue
        thoughtTitle.top = missionStatement.bottom.addPadding(.xXLarge)
        thoughtTitle.left = missionStatement.left
        view.addSubview(thoughtTitle)
        
        thoughtDescription.numberOfLines = 0
        thoughtDescription.width = view.width.subtractPadding(.xLarge, multiplier: 2)
        thoughtDescription.sizeToFit()
        thoughtDescription.top = thoughtTitle.bottom.addPadding(.small)
        thoughtDescription.left = thoughtTitle.left
        view.addSubview(thoughtDescription)
    }
}
