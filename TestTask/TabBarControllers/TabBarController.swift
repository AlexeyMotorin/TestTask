import UIKit

final class TabBarController: UITabBarController {
    
    private enum TabBarItem {
        case page
        case likePage
        case cartPage
        case comments
        case profile
        
        var image: UIImage? {
            switch self {
            case .page:
                return UIImage(named: "pageOne")
            case .likePage:
                return UIImage(named: "LikePage")
            case .cartPage:
                return UIImage(named: "CartPage")
            case .comments:
                return UIImage(named: "CommentsPage")
            case .profile:
                return UIImage(named: "ProfilePage")
            }
        }
        
        var selectImage: UIImage? {
            switch self {
            case .page:
                return UIImage(named: "SelectPageOne")
            case .likePage:
                return UIImage(named: "SelectLikePage")
            case .cartPage:
                return UIImage(named: "SelectCartPage")
            case .comments:
                return UIImage(named: "SelectCommentsPage")
            case .profile:
                return UIImage(named: "SelectProfilePage")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        let items: [TabBarItem] = [.page, .likePage, .cartPage, .comments, .profile]
        
        viewControllers = items.compactMap({ item in
            switch item {
            case .page:
                let viewController = PageOneViewController()
                return UINavigationController(rootViewController: viewController)
            case .likePage:
                let viewController = LikeViewController()
                return UINavigationController(rootViewController: viewController)
            case .cartPage:
                let viewController = CartViewController()
                return UINavigationController(rootViewController: viewController)
            case .comments:
                let viewController = CommentsViewController()
                return UINavigationController(rootViewController: viewController)
            case .profile:
                let viewController = ProfileViewController()
                return UINavigationController(rootViewController: viewController)
            }
        })
        
        viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.image = items[index].image
            vc.tabBarItem.selectedImage = items[index].selectImage?.withRenderingMode(.alwaysOriginal)
        })
        
        setTabBarAppearances()
    }
    
    private func setTabBarAppearances() {
        let width = view.bounds.width
        let height = view.bounds.height / 10
        let roundLayer = CAShapeLayer ()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: -20 ,
                width: width,
                height: 150
            ),
            cornerRadius: height / 2
        )
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer (roundLayer, at: 0)
        tabBar.itemWidth = width / 2
        tabBar.itemPositioning = .centered
        roundLayer.fillColor = UIColor.ttWhite?.cgColor ?? UIColor.white.cgColor
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .ttGray
    }
}
