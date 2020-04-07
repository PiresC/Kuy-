//
//  EditExpenseViewController.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 07/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class EditExpenseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var noteTextField: UITextView!
    
    let picker = UIPickerView()
    let datePicker = UIDatePicker()
    
    var viewController:ExpenseHistoryViewController?
    
    var expense:Expense?
    
    var entertainments = EntertainmentRepository.fetchEntertainments()
    var amount:Int?
    var entertainment:Entertainment?
    var date:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let expense = self.expense{
            amount = Int(expense.price)
            entertainment = expense.entertainment
            date = expense.date
            noteTextField.text = expense.note
        }
        
        picker.delegate = self
        picker.dataSource = self
        
        date = Date()
        
        let entertainmentToolbar = UIToolbar(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        entertainmentToolbar.sizeToFit()
        let addNewEntertainment = UIBarButtonItem(title: "New Entertainment", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onAddEntertainment))
        let entertainmentDone = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(onChangeEntertainment))
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        entertainmentToolbar.setItems([addNewEntertainment, spacer,entertainmentDone], animated: false)
        entertainmentToolbar.isUserInteractionEnabled = true
        
        categoryTextField.inputView = picker
        categoryTextField.inputAccessoryView = entertainmentToolbar
        
        datePicker.datePickerMode = .date
        datePicker.date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let firstOfThisMonth = formatter.date(from: "2020/04/01 00:00")
        datePicker.minimumDate = firstOfThisMonth
        datePicker.maximumDate = Date()
        
        let dateToolbar = UIToolbar(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 45))
        entertainmentToolbar.sizeToFit()
        let dateDone = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(onChangeDate))
        let dateSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        dateToolbar.setItems([dateSpacer,dateDone], animated: false)
        dateToolbar.isUserInteractionEnabled = true
        
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = dateToolbar
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        updateView()
    }
    
    func updateView(){
        saveButton.isEnabled = true
        if let amount = self.amount{
            amountTextField.text = "\(amount)"
        }
        else{
            saveButton.isEnabled = false
        }
        if let entertainment = self.entertainment{
            categoryTextField.text = entertainment.name
        }
        else{
            saveButton.isEnabled = false
        }
        if let date = self.date{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d yyyy"
            let dateString = dateFormatter.string(from: date)
            dateTextField.text = dateString
        }
        else{
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func amountTextChanged(_ sender: Any) {
        amount = Int(amountTextField.text!)
        updateView()
    }
    
    @IBAction func cancelButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClick(_ sender: Any) {
        if let expense = self.expense, let amount = self.amount, let entertainment = self.entertainment, let date = self.date{
            let period = PeriodRepository.getCurrentPeriod()
            if (period!.currentBudget>=Int64(amount)){
                PeriodRepository.updatePeriod(period: period!, startingBudget: period!.startingBudget, currentBudget: period!.currentBudget - Int64(amount) + expense.price)
                ExpenseRepository.updateExpense(expense: expense, newNote: noteTextField.text, newPrice: Int64(amount), newDate: date, newEntertainment: entertainment)
                dismiss(animated: true){
                    self.viewController?.updateView()
                }
            }
            else{
                let insufficientAlert = UIAlertController(title: "Insufficient Entertainment Budget", message: "Your entertainment budget is not enough", preferredStyle: UIAlertController.Style.alert)
                insufficientAlert.addAction(UIAlertAction(title: "Okay", style: .cancel))
                present(insufficientAlert, animated: true, completion: nil)
            }
        }
        else{
            print("kena")
        }
    }
    
    @objc func onAddEntertainment(){
        view.endEditing(true)
    }
    
    @objc func onChangeEntertainment() {
        view.endEditing(true)
        entertainment = entertainments[picker.selectedRow(inComponent: 0)]
        updateView()
    }
    
    @objc func onChangeDate() {
        view.endEditing(true)
        date = datePicker.date
        updateView()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return entertainments.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return entertainments[row].name
    }
}
