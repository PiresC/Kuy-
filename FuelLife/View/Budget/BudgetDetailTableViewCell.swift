//
//  BudgetDetailTableViewCell.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/13/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class BudgetDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var budgetDetailEntertainmentLabel: UILabel!
    
    @IBOutlet weak var budgetDetailEntertainmentPercentage: UILabel!
    
    @IBOutlet weak var budgetDetailCellView: UIView!
    
    var budgetDetail:BudgetDetail!{
        didSet{
            update()
        }
    }
    
    func update(){
        
        budgetDetailEntertainmentLabel.text = budgetDetail.name
        budgetDetailEntertainmentPercentage.text = "\(budgetDetail.percentage)"
            
        self.contentView.backgroundColor = UIColor.clear
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.frame.size.width - 20, height: 120))

        whiteRoundedView.layer.backgroundColor = UIColor(hexString: budgetDetail.backgroundColor).cgColor
         whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 10.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
         whiteRoundedView.layer.shadowOpacity = 0.2

         self.contentView.addSubview(whiteRoundedView)
         self.contentView.sendSubviewToBack(whiteRoundedView)
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
