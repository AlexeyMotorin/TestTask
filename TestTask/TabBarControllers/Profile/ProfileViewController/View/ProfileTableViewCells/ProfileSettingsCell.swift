import UIKit

enum ProfileTypeCell {
    case tradeStore
    case paymentMethods
    case balance
    case tradeHistory
    case restore
    case help
    case logOut
}

class ProfileSettingsCell: UITableViewCell {
    static let reuseIdentifier = "ProfileCell"
    
    private lazy var informationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var informationLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Medium", size: 15)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var forwardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "GoForward")
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var balanceLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat", size: 15)
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        contentView.addSubviews(informationImageView, informationLable, forwardImageView, balanceLable)
        
        let side = UIScreen.main.bounds.height / 20
        
        NSLayoutConstraint.activate([
            informationImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            informationImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            informationImageView.widthAnchor.constraint(equalToConstant: side),
            informationImageView.heightAnchor.constraint(equalToConstant: side),
            
            informationLable.centerYAnchor.constraint(equalTo: informationImageView.centerYAnchor),
            informationLable.leftAnchor.constraint(equalTo: informationImageView.rightAnchor, constant: 10),
            
            forwardImageView.centerYAnchor.constraint(equalTo: informationImageView.centerYAnchor),
            forwardImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40),
            
            balanceLable.centerYAnchor.constraint(equalTo: informationImageView.centerYAnchor),
            balanceLable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40),
            
        ])
    }
    
    func config(typeCell: CellType) {
        
        informationLable.text = typeCell.title
        
        switch typeCell.typeCell {
        case .tradeStore, .paymentMethods, .tradeHistory:
            goForwardCellConfig()
        case .balance:
            guard let balance = typeCell.balance else {
                balanceCellConfig(balance: "Error")
                return
            }
            balanceCellConfig(balance: String(format: "%.0f", balance))
        case .restore:
            restoreCellConfig()
        case .help:
            helpCellConfig()
        case .logOut:
            logOutCellConfig()
        }
    }
    
    private func goForwardCellConfig() {
        informationImageView.image = UIImage(named: "Payment")
        forwardImageView.isHidden = false
    }
    
    private func balanceCellConfig(balance: String) {
        informationImageView.image = UIImage(named: "Payment")
        balanceLable.isHidden = false
        balanceLable.text = "$ \(balance)"
    }
    
    private func restoreCellConfig() {
        informationImageView.image = UIImage(named: "Restore")
        forwardImageView.isHidden = false
    }
    
    private func helpCellConfig() {
        informationImageView.image = UIImage(named: "Help")
    }
    
    private func logOutCellConfig() {
        informationImageView.image = UIImage(named: "LogOut")
    }
}
