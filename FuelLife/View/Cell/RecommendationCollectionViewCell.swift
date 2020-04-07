//
//  RecommendationCollectionViewCell.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/7/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class RecommendationCollectionViewCell: UICollectionViewCell {

    @IBOutlet var recommendationCellLabel: UILabel!
    @IBOutlet var recommendationCellPrice: UILabel?

    static let identifier = "RecommendationCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(recommendationLabel: String, recommendationPrice: String) {
        recommendationCellLabel.text = recommendationLabel
        recommendationCellPrice?.text = recommendationPrice
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "RecommendationCollectionViewCell", bundle: nil)
    }


}
