import UIKit

protocol BrandsTableViewCellProtocol: AnyObject {
    var presenter: BrandsCollectionViewCellPresenterProtocol? { get set }
}

class BrandsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "BrandsTableViewCell"
    
    var presenter: BrandsCollectionViewCellPresenterProtocol?
    
    private lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        label.textColor = .ttBlack
        label.text = "Brands"
        return label
    }()
    
    private lazy var viewAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.ttGray, for: .normal)
        button.setTitle("View all", for: .normal)
        button.addTarget(self, action: #selector(viewAllButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Montserrat", size: 10)
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(BrandCollectionViewCell.self, forCellWithReuseIdentifier: BrandCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPresenter()
        setupCollectionView()
        setupView()
    }
    
    private func setupPresenter() {
        presenter = BrandsCollectionViewCellPresenter()
        presenter?.view = self
        presenter?.viewDidLoad()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = presenter as? BrandsCollectionViewCellPresenter
        collectionView.dataSource = presenter as? BrandsCollectionViewCellPresenter
    }
    
    private func setupView() {
        backgroundColor = .clear
        contentView.addSubviews(
            brandLabel,
            viewAllButton,
            collectionView
        )
        
        NSLayoutConstraint.activate([
            brandLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            brandLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            viewAllButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            viewAllButton.centerYAnchor.constraint(equalTo: brandLabel.centerYAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: brandLabel.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func viewAllButtonTapped() {
        print("View all tapped")
    }
}

extension BrandsTableViewCell: BrandsTableViewCellProtocol {}

