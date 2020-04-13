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

    @IBOutlet weak var budgetDetailExpenseTableView: UITableView!
        
    var budgetDetail:BudgetDetail!{
        didSet{
            update()
        }
    }
        
    func update(){

        budgetDetailEntertainmentLabel.text = budgetDetail.name
        budgetDetailEntertainmentPercentage.text = "\(budgetDetail.percentage)"
            
        self.contentView.backgroundColor = UIColor.clear
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.frame.size.width - 20, height: 180))

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
        
        budgetDetailExpenseTableView.delegate = self
        budgetDetailExpenseTableView.dataSource = self
        
    }

}

extension BudgetDetailTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return budgetDetail?.expenses.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "budgetDetailExpenseTableViewCell", for: indexPath) as! BudgetDetailExpenseTableViewCell
        
        if budgetDetail?.expenses.count ?? 0 > 0 {
            cell.expenseBackgroundColor = budgetDetail.backgroundColor
            cell.expense = budgetDetail.expenses[indexPath.row]
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
}
