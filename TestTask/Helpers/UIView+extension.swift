import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}

extension UIView {
    func addGradient() {
//        let gradient = CAGradientLayer()
//        gradient.frame = CGRect(origin: .zero, size: CGSize(width: 70, height: 70))
//        gradient.locations = [0, 0.1, 0.3]
//        gradient.colors = [
//            UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1).cgColor,
//            UIColor(red: 0.531, green: 0.533, blue: 0.553, alpha: 1).cgColor,
//            UIColor(red: 0.431, green: 0.433, blue: 0.453, alpha: 1).cgColor
//        ]
//        gradient.startPoint = CGPoint(x: 0, y: 0.5)
//        gradient.endPoint = CGPoint(x: 1, y: 0.5)
//        gradient.cornerRadius = 35
//        gradient.masksToBounds = true
//        
//        animationLayers.append(gradient)
//        avatarImageView.layer.addSublayer(gradient)
//        
//        let gradientChangeAnimation = CABasicAnimation(keyPath: "locations")
//        gradientChangeAnimation.duration = 1.0
//        gradientChangeAnimation.repeatCount = .infinity
//        gradientChangeAnimation.fromValue = [0, 0.1, 0.3]
//        gradientChangeAnimation.toValue = [0, 0.8, 1]
//        gradient.add(gradientChangeAnimation, forKey: "locationsChange")
    }
}
