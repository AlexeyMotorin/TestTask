import UIKit

final class BrandCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "BrandCollectionViewCell"
    
    private lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        label.textColor = .ttBlack
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.backgroundColor = UIColor.ttLightGray?.withAlphaComponent(0.7).cgColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        brandLabel.text = nil
    }
    
    func configure(with model: String?) {
        brandLabel.text = model
    }
    
    private func setupView() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 8
        
        addGradientAndAnimation()
        
        contentView.addSubview(brandLabel)
        
        NSLayoutConstraint.activate([
            brandLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            brandLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            brandLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }
    
    private func addGradientAndAnimation() {
        let gradient = CAGradientLayer()
        gradient.frame = contentView.bounds
        gradient.locations = [0, 0.1, 0.3]
        gradient.colors = [
            UIColor.white.cgColor,
            UIColor.lightGray,
            UIColor.gray.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.cornerRadius = contentView.layer.cornerRadius
        gradient.masksToBounds = true
        
        contentView.layer.addSublayer(gradient)
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "locations")
        gradientChangeAnimation.duration = 10
        gradientChangeAnimation.repeatCount = .infinity
        gradientChangeAnimation.autoreverses = true
        gradientChangeAnimation.fromValue = [0, 0.1, 0.3]
        gradientChangeAnimation.toValue = [0, 0.8, 1]
        gradient.add(gradientChangeAnimation, forKey: "locationsChange")
    }
}
