import UIKit
import Kingfisher

final class FlashSaleCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "FlashSaleCollectionViewCell"
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var sellerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "Seller")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.contentMode = .scaleAspectFit
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
    
    private lazy var likeProductButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "LikeProduct"), for: .normal)
        button.imageView?.clipsToBounds = true
        button.addTarget(self, action: #selector(likeProductButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 7)
        label.textColor = .ttBlack
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.backgroundColor = UIColor.ttLightGray?.withAlphaComponent(0.7).cgColor
        return label
    }()
    
    private lazy var saleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 10)
        label.textColor = .ttWhite
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.backgroundColor = UIColor.ttRed?.cgColor
        return label
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 10)
        label.textColor = .ttWhite
        label.textAlignment = .left
        label.numberOfLines = 0
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
    
    func configure(with model: ProductCellModel?) {
        downloadImage(at: model?.imageURL)
        sellerImageView.image = UIImage(named: model?.sellerImageURL ?? "Error")
        categoryLabel.text = model?.category
        nameLabel.text = model?.name
        saleLabel.text = "\(model?.discount ?? 0)% off"
        priceLabel.text = "$ \(model?.price ?? 0)"
    }
    
    private func setupView() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = false
        
        contentView.addSubviews(
            productImageView,
            addProductButton,
            categoryLabel,
            nameLabel,
            priceLabel,
            likeProductButton,
            saleLabel,
            sellerImageView
        )
        
        NSLayoutConstraint.activate([
            productImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            addProductButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            addProductButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            addProductButton.widthAnchor.constraint(equalToConstant: 35),
            addProductButton.heightAnchor.constraint(equalToConstant: 35),
            
            likeProductButton.centerYAnchor.constraint(equalTo: addProductButton.centerYAnchor),
            likeProductButton.rightAnchor.constraint(equalTo: addProductButton.leftAnchor, constant: -5),
            likeProductButton.widthAnchor.constraint(equalToConstant: 28),
            likeProductButton.heightAnchor.constraint(equalToConstant: 28),
            
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.bounds.height / 1.7),
            categoryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            categoryLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 3),
            categoryLabel.heightAnchor.constraint(equalToConstant: contentView.bounds.width / 8),
            
            nameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            nameLabel.leftAnchor.constraint(equalTo: categoryLabel.leftAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            priceLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            saleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            saleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            saleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 3.5),
            saleLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height / 12.7),
            
            sellerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            sellerImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            sellerImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width / 7.25),
            sellerImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width / 7.25)
        ])
    }
    
    private func downloadImage(at url: String?) {
        guard
            let urlString = url,
            let url = URL(string: urlString) else { return }
        productImageView.kf.setImage(with: url)
    }
    
    @objc private func addProductTapped() {
        print("добавили товар")
    }
    
    @objc private func  likeProductButtonTapped() {
        print("добавили в избранное")
    }
}
