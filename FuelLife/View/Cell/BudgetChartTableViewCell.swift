//
//  BudgetChartTableViewCell.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/8/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class BudgetChartTableViewCell: UITableViewCell {

    @IBOutlet weak var budgetChartView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        budgetChartView.layer.cornerRadius = 10
        budgetChartView.layer.borderWidth = 0.4
        budgetChartView.layer.borderColor = UIColor.lightGray.cgColor
        
        budgetChartView.layer.shadowColor = UIColor.gray.cgColor
        budgetChartView.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        budgetChartView.layer.shadowRadius = 2.0
        budgetChartView.layer.shadowOpacity = 0.7
        budgetChartView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
