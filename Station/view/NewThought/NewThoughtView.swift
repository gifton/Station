
import UIKit

class NewThoughtView: UIView {
    
    init() {
        super.init(frame: Device.frame)
        
        backgroundColor = Styles.Colors.offWhite
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var thoughtDelegate: NewThoughtViewDelegate?
    
    private let saveButton = ConfirmationButton(point: .zero, color: .regular, text: "Save", width: .full)
    private var orbitView: OrbitSelector!
    private var card: NewThoughtCard!
    
    private var selectedOrbits: [Orbit] = []
    
    public func needsReset() {
        
        orbitView.needReset()
        
    }
}


private extension NewThoughtView {
    func setView() {
        // set thought card
        card = NewThoughtCard(point: .init(Styles.Padding.large.rawValue, 65))
        card.thoughtDelegate = self
        
        addSubview(card)
        // set orbits display
        orbitView = OrbitSelector(point: .init(Styles.Padding.medium.rawValue, card.bottom + Styles.Padding.large.rawValue), title: "Add Orbits", delegate: self, numberOfRows: 3)
        addSubview(orbitView)
        // set save button
        saveButton.frame.origin = .init(Styles.Padding.medium.rawValue, bottom - 50 - 100 )
        saveButton.addTapGestureRecognizer(action: didPressSave)
        thoughtHasContent(false)
        
        addSubview(saveButton)
        
    }
    
    func didPressSave() {
        thoughtDelegate?.save(withTitle: card.thoughtText, andOrbits: selectedOrbits)
        card.reset()
        orbitView.needReset()
    }
    
    func thoughtHasContent(_ isAvailable: Bool) {
        if isAvailable {
            saveButton.alpha = 1.0
            saveButton.isEnabled = true
            orbitView.setAvalibility(true)
        } else {
            saveButton.alpha = 0.4
            saveButton.isEnabled = false
        }
    }
}


extension NewThoughtView: NewThoughtCardDelegate {
    func titleUpdated() {
        if card.thoughtText != "" {
            thoughtHasContent(true)
        } else {
            thoughtHasContent(false)
        }
    }
}

extension NewThoughtView: OrbitSelectorDelegate {
    
    func filterOrbits(withPredicate predicate: String) {
        thoughtDelegate?.filterOrbits(withPredicate: predicate)
    }
    func didSelectOrbit(atIndex index: Int) {
        
        if !(selectedOrbits.contains(orbits[index])) {
            selectedOrbits.append(orbits[index])
        }
        
    }
    
    func createNewOrbit() {
        thoughtDelegate?.newOrbit()
        
    }
    var orbits: [Orbit] {
        return thoughtDelegate?.orbits ?? []
    }
}
