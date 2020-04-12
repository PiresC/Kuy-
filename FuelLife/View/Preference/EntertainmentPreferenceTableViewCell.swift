//
//  EntertainmentPreferenceTableViewCell.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/10/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class EntertainmentPreferenceTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var colorTagView: UIView!
        
    var entertainment:Entertainment?{
        didSet{
            update()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(){
        colorTagView.layer.cornerRadius = 15
        title.text = entertainment?.name
        colorTagView.backgroundColor = UIColor(hexString: entertainment?.color ?? "#32a852")
    }

}
