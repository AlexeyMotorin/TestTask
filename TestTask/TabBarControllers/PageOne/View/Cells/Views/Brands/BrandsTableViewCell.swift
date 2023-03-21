//
//  BrandsTableViewCell.swift
//  TestTask
//
//  Created by Алексей Моторин on 20.03.2023.
//

import UIKit

class BrandsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "BrandsTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
