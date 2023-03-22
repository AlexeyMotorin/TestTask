
import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CategoryCollectionViewCell"
    
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat", size: 10)
        label.textColor = .ttGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        activateConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        categoryImageView.image = nil
        categoryLabel.text = nil
    }
    
    func configure(with cell: CategoryProductModel) {
        let image = UIImage(named: cell.imageString)
        categoryImageView.image = image
        categoryLabel.text = cell.nameCategory
    }
    
    private func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        addSubviews(categoryImageView, categoryLabel)
    }
    
    private func activateConstraint() {
        NSLayoutConstraint.activate([
            categoryImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            
            categoryLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 10),
            categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
