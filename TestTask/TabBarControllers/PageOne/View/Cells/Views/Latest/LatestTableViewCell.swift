import UIKit

protocol LatestTableViewCellProtocol: AnyObject {
    var presenter: LatestCollectionViewPresenterProtocol? { get set }
}


class LatestTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "LatestTableViewCell"
    
    var presenter: LatestCollectionViewPresenterProtocol?
    
    private lazy var latestLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        label.textColor = .ttBlack
        label.text = "Latest"
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
        collectionView.register(LatestCollectionViewCell.self, forCellWithReuseIdentifier: LatestCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        presenter = LatestCollectionViewPresenter()
        presenter?.view = self
        collectionView.delegate = presenter as? LatestCollectionViewPresenter
        collectionView.dataSource = presenter as? LatestCollectionViewPresenter
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        contentView.addSubviews(latestLabel, viewAllButton, collectionView)
        
        NSLayoutConstraint.activate([
            latestLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            latestLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            viewAllButton.rightAnchor.constraint(equalTo: rightAnchor),
            viewAllButton.topAnchor.constraint(equalTo: topAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: latestLabel.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc private func viewAllButtenTapped() {
        print("View all tapped")
    }
}

extension LatestTableViewCell: LatestTableViewCellProtocol {}
