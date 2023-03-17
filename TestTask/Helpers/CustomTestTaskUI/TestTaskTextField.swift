import UIKit

final class TestTaskTextField: UITextField {
    
    init(frame: CGRect, placeHolderText: String) {
        super.init(frame: frame)
        textFieldConfig()
        placeholder = placeHolderText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func textFieldConfig() {
       translatesAutoresizingMaskIntoConstraints = false
        autocorrectionType = .no
       textAlignment = .center
       layer.cornerRadius = 16
       backgroundColor = .ttLightGray
       let grayColor: UIColor = .ttGray ?? UIColor.gray
        
        let font = UIFont(name: "Montserrat", size: 12) ?? UIFont()
        let attributes = [
            NSAttributedString.Key.foregroundColor : grayColor,
            NSAttributedString.Key.font : font
        ]
        
        attributedPlaceholder = NSAttributedString(
            string: "Placeholder text",
            attributes: attributes )
    }
}
