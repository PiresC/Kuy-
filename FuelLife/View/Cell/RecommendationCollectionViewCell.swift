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
    }
    
    public func configure(recommendationLabel: String, recommendationPrice: String) {
        recommendationCollectionViewCellLabel.text = recommendationLabel
        recommendationCollectionViewCellPrice?.text = recommendationPrice
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "RecommendationCollectionViewCell", bundle: nil)
    }


}
