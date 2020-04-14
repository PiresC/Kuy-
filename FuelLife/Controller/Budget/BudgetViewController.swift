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
    
    @IBOutlet weak var budgetDetailTableView: UITableView!
    
    var budgetDetails: [BudgetDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        budgetDetailTableView.delegate = self
        budgetDetailTableView.dataSource = self
        
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
                
        if let startingBudget = budget?.startingBudget {
            currentBudgetTextField.text = "\(startingBudget)"
            currentBudgetLabel.text = CurrencyFormatter.format(Int(exactly:startingBudget) ?? 0)
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
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataChanged"), object: nil)
        
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
        return 200
    }
    
}
