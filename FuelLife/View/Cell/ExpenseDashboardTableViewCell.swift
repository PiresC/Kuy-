//
//  ExpenseDashboardTableViewCell.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/8/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class ExpenseDashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var expenseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        expenseView.layer.cornerRadius = 10
        expenseView.layer.borderWidth = 0.4
        expenseView.layer.borderColor = UIColor.lightGray.cgColor
        
        expenseView.layer.shadowColor = UIColor.gray.cgColor
        expenseView.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        expenseView.layer.shadowRadius = 2.0
        expenseView.layer.shadowOpacity = 0.7
        expenseView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
