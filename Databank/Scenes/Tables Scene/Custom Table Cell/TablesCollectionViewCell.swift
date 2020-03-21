//
//  TablesCollectionViewCell.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright © 2020 Narcis Zait. All rights reserved.
//

import UIKit

protocol TablesCellCustomasiableProtocol {
    func configure(title: String, firstPeriod: String, latestPeriod: String, tableID: String)
}

class TablesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstPeriodLabel: UILabel!
    @IBOutlet weak var latestPeriodLabel: UILabel!
    @IBOutlet weak var tableIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.systemBackground.cgColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        self.layer.cornerRadius = 20

    }
}

extension TablesCollectionViewCell: TablesCellCustomasiableProtocol {
    func configure(title: String, firstPeriod: String, latestPeriod: String, tableID: String) {
        self.titleLabel.text = title
        self.firstPeriodLabel.text = firstPeriod
        self.latestPeriodLabel.text = latestPeriod
        self.tableIDLabel.text = tableID
    }
}
