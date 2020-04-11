//
//  PreferencesOnboardingCell.swift
//  FuelLife
//
//  Created by Arie May Wibowo on 11/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class PreferencesOnboardingCell: UICollectionViewCell {

    @IBOutlet weak var imagePreference: UIImageView!
    @IBOutlet weak var titlePreference: UILabel!
    @IBOutlet weak var colorCategory: UIButton!
    
    static let identifier = "PreferencesOnboardingCell"
    
    var color: UIColor?
    var title: String = ""
    var image: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagePreference.image = UIImage.init(imageLiteralResourceName: "travel")
        colorCategory.tintColor = UIColor.blue
        titlePreference.text = "Traveling"
    }
    
    public func configure(image: UIImage, title: String, color: UIColor) {
        self.imagePreference.image = image
        self.titlePreference.text? = title
        self.colorCategory.tintColor? = color
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "PreferencesOnboardingCell", bundle: nil)
    }
    
}
