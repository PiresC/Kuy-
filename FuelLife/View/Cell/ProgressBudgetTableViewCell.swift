//
//  ProgressBudgetTableViewCell.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/8/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class ProgressBudgetTableViewCell: UITableViewCell {
    

    @IBOutlet weak var availableBudgetView: UIView!
    @IBOutlet weak var availableBudgetLabel: UILabel!
    @IBOutlet weak var availableBudgetAmountLabel: UILabel!
    
    @IBOutlet weak var usedBudgetView: UIView!
    @IBOutlet weak var usedBudgetLabel: UILabel!
    @IBOutlet weak var usedBudgetAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        availableBudgetView.layer.cornerRadius = 10
        availableBudgetView.layer.borderWidth = 1.0
        availableBudgetView.layer.borderColor = UIColor.lightGray.cgColor
        
        availableBudgetView.layer.shadowColor = UIColor.gray.cgColor
        availableBudgetView.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        availableBudgetView.layer.shadowRadius = 2.0
        availableBudgetView.layer.shadowOpacity = 0.7
        availableBudgetView.layer.masksToBounds = false
        

        usedBudgetView.layer.cornerRadius = 10
        usedBudgetView.layer.borderWidth = 1.0
        usedBudgetView.layer.borderColor = UIColor.lightGray.cgColor
        
        usedBudgetView.layer.shadowColor = UIColor.gray.cgColor
        usedBudgetView.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        usedBudgetView.layer.shadowRadius = 2.0
        usedBudgetView.layer.shadowOpacity = 0.7
        usedBudgetView.layer.masksToBounds = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
