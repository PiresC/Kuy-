//
//  ExpenseTableViewCell.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 05/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var expense:Expense!{
        didSet{
            update()
        }
    }
    
    func update(){
        let dateFormat = expense.date!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d yyyy"
        let dateString = dateFormatter.string(from: dateFormat)
        
        title.text = expense.entertainment?.name
        date.text = dateString
        price.text = "Rp. \(expense.price)"
    }

}
