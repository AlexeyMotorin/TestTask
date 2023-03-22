import UIKit

protocol FlashSaleTableViewCellProtocol: AnyObject {
    var presenter: FlashSaleCollectionViewPresenterProtocol? { get set }
    func requestUpdateCollectionView()
}

class FlashSaleTableViewCell: UITableViewCell {

    static let reuseIdentifier = "FlashSaleTableViewCell"
    
    var presenter: FlashSaleCollectionViewPresenterProtocol?
    
    private lazy var flashSaleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        label.textColor = .ttBlack
        label.text = "Flash sale"
        return label
    }()
    
    private lazy var viewAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.ttGray, for: .normal)
        button.setTitle("View all", for: .normal)
        button.addTarget(self, action: #selector(viewAllButtenTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Montserrat", size: 10)
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(FlashSaleCollectionViewCell.self, forCellWithReuseIdentifier: FlashSaleCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        presenter = FlashSaleCollectionViewPresenter()
        presenter?.view = self
        presenter?.viewDidLoad()
        collectionView.delegate = presenter as? FlashSaleCollectionViewPresenter
        collectionView.dataSource = presenter as? FlashSaleCollectionViewPresenter
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        contentView.addSubviews(flashSaleLabel, viewAllButton, collectionView)
        
        NSLayoutConstraint.activate([
            flashSaleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            flashSaleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            viewAllButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            viewAllButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: flashSaleLabel.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func viewAllButtenTapped() {
        print("View all tapped")
    }
}

extension FlashSaleTableViewCell: FlashSaleTableViewCellProtocol {
    func requestUpdateCollectionView() {
        collectionView.reloadData()
    }
}

