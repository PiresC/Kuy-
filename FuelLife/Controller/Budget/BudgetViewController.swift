//
//  BudgetViewController.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/12/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController {

    @IBOutlet weak var currentBudgetLabel: UILabel!
    @IBOutlet weak var editBudgetButton: UIButton!
    @IBOutlet weak var currentBudgetTextField: UITextField!
    
    @IBOutlet weak var BudgetDetailTableView: UITableView!
    
    var budgetDetails: [BudgetDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BudgetDetailTableView.delegate = self
        BudgetDetailTableView.dataSource = self
        
        self.updateBudgetText()

        currentBudgetTextField.isHidden = true
        currentBudgetTextField.delegate = self
        
        budgetDetails = Budget.getCurrentBudgetDetails()
                
    }
    
    @IBAction func editBudgetAction(_ sender: UIButton) {
        currentBudgetLabel.isHidden = true
        currentBudgetTextField.isHidden = false
    }
    
}

extension BudgetViewController  {
    func updateBudgetText(){
        let budget = PeriodRepository.getCurrentBudget()
                
        if let current_budget = budget?.currentBudget {
            currentBudgetTextField.text = "\(current_budget)"
            currentBudgetLabel.text = CurrencyFormatter.format(Int(exactly:current_budget) ?? 0)
        } else {
            currentBudgetTextField.text = "0"
            currentBudgetLabel.text = "0"
        }
    }
}

extension BudgetViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        PeriodRepository.editBudget(newBudget: Int64(textField.text ?? "0")!)
        textField.resignFirstResponder()
        
        self.updateBudgetText()
        currentBudgetLabel.isHidden = false
        currentBudgetTextField.isHidden = true
        return true
    }
}

extension BudgetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgetDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "budgetTableViewCell", for: indexPath) as! BudgetDetailTableViewCell
        cell.budgetDetail = budgetDetails[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
}


