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
    var imageName: String = ""
    var testName: String = "travel-col"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagePreference.image = UIImage.init(imageLiteralResourceName: "travel")
        colorCategory.tintColor = UIColor.blue
        titlePreference.text = "Traveling"
    }
    
    public func configure(image: String, title: String, color: UIColor) {
        self.imageName = image
        self.imagePreference.image = UIImage(named: image)
        self.titlePreference.text? = title
        self.colorCategory.tintColor? = color
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "PreferencesOnboardingCell", bundle: nil)
    }
    
    override var isSelected: Bool {
        willSet(bool) {
            let splittedName = imageName.split(separator: "-")
            if splittedName[0] != imageName {
                imageName = String(splittedName[0])
                self.imagePreference.image = UIImage(named: imageName)
            } else {
                imageName = "\(imageName)-col"
                self.imagePreference.image = UIImage(named: imageName)
            }
        }
    }
    
}
