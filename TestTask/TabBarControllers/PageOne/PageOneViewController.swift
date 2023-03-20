//
//  PageOneViewController.swift
//  TestTask
//
//  Created by Алексей Моторин on 17.03.2023.
//

import UIKit

class PageOneViewController: UIViewController {
    
    private lazy var menuBarItemButton: UIBarButtonItem = {
        let menuImage = UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal)
        let item = UIBarButtonItem(
            image: menuImage,
            style: .done,
            target: self,
            action: #selector(menuBarItemButtonTapped)
        )
        return item
    }()
    
    private lazy var titleNavBarLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 25)
        let attributedString = NSMutableAttributedString(string: "Trade by bata")
        attributedString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: UIColor.ttPurple ?? UIColor.purple,
            range: NSRange(location: 9, length: 4)
        )
        label.attributedText = attributedString
        return label
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
    }
    
    private func setupViews() {
        view.backgroundColor = .ttBackgroundColor
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = menuBarItemButton
        navigationItem.titleView = titleNavBarLabel
        
        guard
            let imageString = AccountStorage.shared.profile?.profileImage,
            let image = UIImage(named: imageString) else { return }
        let locationView = LocationView(
                frame: CGRect(x: 0,
                              y: 0,
                              width: view.frame.size.width / 5,
                              height: navigationController?.navigationBar.bounds.height ?? 0),
                image: image)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(locationButtontapped))
        locationView.addGestureRecognizer(tapGesture)
        
        let rightBarButtonItem = UIBarButtonItem(customView: locationView)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func menuBarItemButtonTapped() {
        print("menuBarItemButtonTapped")
    }
    
    
    @objc private func locationButtontapped() {
        print("locationButtontapped")
    }
}
