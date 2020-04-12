//
//  ExpenseDashboardTableViewCell.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/8/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class LastExpensesTableViewCell: UITableViewCell {

    @IBOutlet weak var expenseView: UIView!
    @IBOutlet weak var lastExpenseTableView: UITableView!
    
    var dashboardView: DashboardController?
    
    var expenses:[Expense] = []{
        didSet{
            expenses = ExpenseRepository.fetchExpenses()
            expenses.reverse()
        }
    }
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
        
        lastExpenseTableView.dataSource = self
        lastExpenseTableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDashboardExpenseTableView), name: NSNotification.Name(rawValue: "reloadEDashboardExpenseTableView"), object: nil)
        
    }
    
    @objc func reloadDashboardExpenseTableView(notification: NSNotification){
        self.lastExpenseTableView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func seeDetailButtonClick(_ sender: Any) {
        if let dashboard = dashboardView{
            dashboard.performSegue(withIdentifier: "expenseHistory", sender: dashboard)
        }
    }
}

extension LastExpensesTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lastExpensesTableViewCell", for: indexPath) as! ExpenseTableViewCell
       
        expenses = ExpenseRepository.fetchExpenses()
        expenses.reverse()
        cell.expense = expenses[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
