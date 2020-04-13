//
//  BudgetDetailExpenseTableViewCell.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/13/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class BudgetDetailExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var expenseDateLabel: UILabel!
    @IBOutlet weak var expensePriceLabel: UILabel!
    
    
    var expense: Expense!{
        didSet{
            update()
        }
    }
    
    var expenseBackgroundColor: String = ""
            
    func update(){
        self.contentView.backgroundColor = UIColor(hexString: expenseBackgroundColor)

        expensePriceLabel.text = "\(expense.price)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d yyyy"
        let dateString = dateFormatter.string(from: expense.date!)
        
        expenseDateLabel.text = dateString

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

