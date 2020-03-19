
import UIKit

extension NewSubThoughtController {
    func setLinkView() {
        
        linkTextView.font = Styles.Font.body(ofSize: .large)
        linkTextView.layer.cornerRadius = 8
        linkTextView.frame = CGRect(x: CGFloat(0).addPadding(.xLarge), y: 150, width: view.width / 1.75, height: 45)
        linkTextView.backgroundColor = Colors.white
        linkTextView.text = "Insert Link"
        linkTextView.autocapitalizationType = .sentences
        linkTextView.returnKeyType = .done
        linkTextView.delegate = self
        linkTextView.keyboardType = .URL
        
        pasteFromClipboard.left = linkTextView.right.addPadding()
        pasteFromClipboard.top = linkTextView.top
        pasteFromClipboard.height = linkTextView.height
        
        view.addSubview(linkTextView)
        view.addSubview(pasteFromClipboard)
    }
    
    func setLinkPreview() {
        print("setting preview")
        linkIcon.frame.size = .init(150)
        linkIcon.center.x = view.bounds.center.x
        linkIcon.top = linkTextView.bottom.addPadding(.xLarge)
        linkIcon.kf.setImage(with: URL(string: linkPreview.iconURL))
        linkIcon.layer.cornerRadius  =  6
        linkIcon.layer.masksToBounds = true
        linkIcon.backgroundColor = .white
        view.addSubview(linkIcon)
        
        linkDescription.text = linkPreview.description
        linkDescription.numberOfLines = 0
        linkDescription.width = view.width.subtractPadding(.xXLarge, multiplier: 2)
        linkDescription.height = 100
        linkDescription.top = linkIcon.bottom.addPadding()
        linkDescription.center.x = view.center.x
        view.addSubview(linkDescription)
        
    }
    
    func checkURL(_ url: String?) {
        
        if let url = url {
            linkIcon.removeFromSuperview()
            linkDescription.removeFromSuperview()
            slp.preview(url, onSuccess: { (body) in
                self.linkPreview = .init(body) })
            { (error) in
                print(error)
                self.linkErrorLabel.sizeToFit()
                self.linkErrorLabel.center = self.view.bounds.center
                self.linkErrorLabel.textColor = .red
                self.view.addSubview(self.linkErrorLabel)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.linkErrorLabel.removeFromSuperview()
                }
            }
        }
    }
}
