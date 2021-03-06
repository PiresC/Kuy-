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
    
    var color: String = ""
    
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
    
    public func configure(recommendationLabel: String, recommendationPrice: String, recommendationColor: String) {
        recommendationCollectionViewCellLabel.text = recommendationLabel
        recommendationCollectionViewCellPrice?.text = recommendationPrice
        
        self.layer.backgroundColor = UIColor(hexString: recommendationColor).cgColor


            //it is the time for us to  call an accessibility function we created before.
            applyAccessibility(data: "\(recommendationLabel) \(String(recommendationPrice))")
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "RecommendationCollectionViewCell", bundle: nil)
    }



    //Function to implementing the accessibility on a collectionView that sitting at  the tableView.
    //By Aris Yohanes Elean
    final func applyAccessibility(data: String)
{
    isAccessibilityElement = true
    accessibilityLabel = "\(data)"
    accessibilityHint =  "Double tab to select"
    recommendationCollectionViewCellLabel.isAccessibilityElement = false
    recommendationCollectionViewCellPrice?.isAccessibilityElement = false
    }
}

