import UIKit

final class LocationView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.ttGray?.cgColor
        return imageView
    }()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Location ", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 12)
        button.tintColor = .ttBlack
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 8)
        button.setImage(UIImage(named: "down"), for: .normal)
        return button
    }()
    
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        imageView.image = image
        setupView()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        addSubviews(imageView, locationButton)
    }
    
    private func activateConstraints() {
        
        let side = frame.height / 1.3
        imageView.layer.cornerRadius = side / 2
    
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: frame.width),
            heightAnchor.constraint(equalToConstant: frame.height),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: side),
            imageView.heightAnchor.constraint(equalToConstant: side),
            
            locationButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            locationButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3)
        ])
    }
}
