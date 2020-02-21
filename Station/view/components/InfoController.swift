
import UIKit

enum InfoType: String {
    case general = "Station"
    case orbit = "Orbits"
    case subThought = "Sub Thoughts"
    case thought = "Thoughts"
}

class InfoController: Controller {
    
    init(type: InfoType) {
        infoType = type
        super.init(nibName: nil, bundle: nil)
        
        switch type {
        case .general: buildGeneralInfo()
        case .orbit: buildOrbitInfo()
        case .subThought: buildSubThoughtInfo()
        case .thought: buildThoughtInfo()
        }
        
        buildHeaders()
    }
    
    var infoType: InfoType
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel = UILabel.titleLabel("Station", .xXLarge)
    let infoButton = Icons.iv(withImageType: .info, size: .init(35))
    let typeLabel = UILabel.mediumTitleLabel()
}


private  extension InfoController {
    
    func buildHeaders() {
        titleLabel.sizeToFit()
        infoButton.sizeToFit()
        
        view.addSubview(titleLabel)
        view.addSubview(infoButton)
        
        titleLabel.pin(onEdge: .left, withPadding: .large)
        titleLabel.pin(onEdge: .top, withPadding: .large)
        
    }
    
    func buildGeneralInfo() {
        
    }
    
    func buildOrbitInfo() {
        
    }
    
    func buildSubThoughtInfo() {
        
    }
    
    func buildThoughtInfo() {
        
    }
}
