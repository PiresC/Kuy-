//
//  RecommendationCollectionViewCell.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/7/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class RecommendationCollectionViewCell: UICollectionViewCell {

    @IBOutlet var recommendationCollectionViewCellLabel: UILabel!
    @IBOutlet var recommendationCollectionViewCellPrice: UILabel?

    static let identifier = "RecommendationCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.7
        self.layer.masksToBounds = false
        
        //self.clipsToBounds = true
        //self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        //self.layer.borderWidth = 1.0
        //self.layer.borderColor = UIColor.lightGray.cgColor
 
    }
    
    public func configure(recommendationLabel: String, recommendationPrice: String) {
        recommendationCollectionViewCellLabel.text = recommendationLabel
        recommendationCollectionViewCellPrice?.text = recommendationPrice
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "RecommendationCollectionViewCell", bundle: nil)
    }


}
