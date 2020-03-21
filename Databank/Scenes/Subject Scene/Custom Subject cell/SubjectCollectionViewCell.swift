//
//  SubjectCollectionViewCell.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright © 2020 Narcis Zait. All rights reserved.
//

import UIKit

protocol SubjectCellCustomisableProtocol {
    func configure(title: String)
}

class SubjectCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.systemBackground.cgColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        self.layer.cornerRadius = 20
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.8
    }

}

extension SubjectCollectionViewCell: SubjectCellCustomisableProtocol {
    func configure(title: String) {
        self.titleLabel.text = title
    }
}
