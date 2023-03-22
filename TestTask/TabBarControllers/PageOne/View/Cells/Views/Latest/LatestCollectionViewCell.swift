import UIKit
import Kingfisher

final class LatestCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "LatestCollectionViewCell"
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var addProductButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "AddButton"), for: .normal)
        button.imageView?.clipsToBounds = true
        button.addTarget(self, action: #selector(addProductTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 7)
        label.textColor = .ttBlack
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.layer.backgroundColor = UIColor.ttLightGray?.withAlphaComponent(0.7).cgColor
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 8)
        label.textColor = .ttWhite
        label.textAlignment = .left
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 8)
        label.textColor = .ttWhite
        label.textAlignment = .left
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
        productImageView.image = nil
        categoryLabel.text = nil
        nameLabel.text = nil
        priceLabel.text = nil
    }
    
    func configure(with model: LatestProductModel?) {
        // TODO: скачать картинку
        downloadImage(at: model?.imageURL)
        categoryLabel.text = model?.category
        nameLabel.text = model?.name
        
        priceLabel.text = "$ \(model?.price ?? 0)"
    }
    
    private func setupView() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = false
        
        contentView.addSubviews(productImageView, addProductButton, categoryLabel, nameLabel, priceLabel)
        
        NSLayoutConstraint.activate([
            productImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            addProductButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            addProductButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            addProductButton.widthAnchor.constraint(equalToConstant: 20),
            addProductButton.heightAnchor.constraint(equalToConstant: 20),
            
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.bounds.height / 1.7),
            categoryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            categoryLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 3),
            categoryLabel.heightAnchor.constraint(equalToConstant: contentView.bounds.width / 8),
            
            nameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            nameLabel.leftAnchor.constraint(equalTo: categoryLabel.leftAnchor),
            
            priceLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }


    @objc private func addProductTapped() {
        print("добавили товар")
    }
    
    private func downloadImage(at url: String?) {
        guard
            let urlString = url,
            let url = URL(string: urlString) else { return }
        productImageView.kf.indicatorType = .activity
        
        productImageView.kf.setImage(with: url)
//        productImageView.kf.setImage(with: url, placeholder: UIImage(named: "Stub"), options: nil) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let value):
//                self.productImageView.image = value.image
//            case .failure(_):
//                self.cellImageView.image = UIImage(named: "Stub")
//            }
//        }
    }
    
}
