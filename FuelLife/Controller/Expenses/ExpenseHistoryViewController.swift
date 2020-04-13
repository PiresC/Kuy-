//
//  ExpenseHistoryViewController.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 05/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class ExpenseHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var expenses:[Expense] = []{
        didSet{
            expenses.reverse()
        }
    }
    
    var periods:[Period] = PeriodRepository.fetchPeriods()
    var period:Period? = PeriodRepository.getCurrentPeriod()
    @IBOutlet weak var prevPeriodButton: UIButton!
    @IBOutlet weak var nextPeriodButton: UIButton!
    
    let picker = UIPickerView()
    @IBOutlet weak var expenseTableView: UITableView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var monthTextField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        period = PeriodRepository.getCurrentPeriod()
        periods = PeriodRepository.fetchPeriods()
        
        expenseTableView.dataSource = self
        expenseTableView.delegate = self

        picker.delegate = self
        picker.dataSource = self
        
        picker.selectRow(periods.count-1, inComponent: 0, animated: false)
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(onChangePeriod))
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spacer,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        expenseTableView.keyboardDismissMode = .onDrag
        
        monthTextField.inputView = picker
        monthTextField.inputAccessoryView = toolBar
        
        updateView()
    }
    
    @objc func onChangePeriod() {
        period = periods[picker.selectedRow(inComponent: 0)]
        updateView()
        view.endEditing(true)
    }
    
    func updateView(){
        prevPeriodButton.isHidden = periods.firstIndex(of: period!) == 0 ? true : false
        nextPeriodButton.isHidden = periods.firstIndex(of: period!) == periods.count-1 ? true : false
        
        expenses = period?.expenses?.array as! [Expense]
        expenseTableView.reloadData()
        
        let periodString = convertDate(period!.month!)
        monthTextField.text = periodString
        
        var amount = 0
        for i in expenses{
            amount += Int(exactly:i.price ) ?? 0
        }
        totalAmountLabel.text = CurrencyFormatter.format(amount)
    }
    
    func deleteExpense(index:Int){
        let expense = expenses[index]
        
        let refreshAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this expense?", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel))
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action: UIAlertAction!) in
            PeriodRepository.updatePeriod(period: self.period!, startingBudget: self.period!.startingBudget, currentBudget: self.period!.currentBudget + Int64(expense.price))
                ExpenseRepository.deleteExpense(expense: expense)
                self.updateView()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataChanged"), object: nil)
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func prevPeriodButtonClick(_ sender: Any) {
        period = periods[(periods.firstIndex(of: period!) ?? 1 )-1]
        picker.selectRow(picker.selectedRow(inComponent: 0)-1, inComponent: 0, animated: false)
        updateView()
    }
    
    @IBAction func nextPeriodButtonClick(_ sender: Any) {
        period = periods[(periods.firstIndex(of: period!) ?? -1 )+1]
        picker.selectRow(picker.selectedRow(inComponent: 0)+1, inComponent: 0, animated: false)
        updateView()
    }
    
    @IBAction func addExpenseButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "addExpense", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addExpense"){
            if let destination = segue.destination as? AddExpenseViewController{
                destination.viewController = self
            }
        }
        else if (segue.identifier == "expenseDetail"){
            if let destination = segue.destination as? ExpenseDetailViewController, let expense = sender as? Expense{
                destination.expense = expense
            }
        }
        else if (segue.identifier == "editExpense"){
            if let destination = segue.destination as? EditExpenseViewController, let expense = sender as? Expense{
                destination.expense = expense
                destination.viewController = self
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseTableViewCell
        cell.expense = expenses[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.deleteExpense(index: indexPath.row)
            success(true)
        })
        delete.backgroundColor = .red
        
        let edit = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.performSegue(withIdentifier: "editExpense", sender: self.expenses[indexPath.row])
            success(true)
        })
        edit.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "expenseDetail", sender: expenses[indexPath.row])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return periods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return convertDate(periods[row].month!)
    }

    func convertDate(_ date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"
        let dateDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM yyyy"
        return  dateFormatter.string(from: dateDate!)

    }

}
