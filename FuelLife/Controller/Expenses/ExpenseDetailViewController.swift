//
//  ExpenseDetailViewController.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 07/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class ExpenseDetailViewController: UIViewController {
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var entertainmentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteLabel: UITextView!
    
    var expense:Expense?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let expense = self.expense{
            amountLabel.text = CurrencyFormatter.format(Int(expense.price))
            entertainmentLabel.text = expense.entertainment!.name
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d yyyy"
            let dateString = dateFormatter.string(from: expense.date!)
            dateLabel.text = dateString
            noteLabel.text = expense.note
        }
    }
    
    
    @IBAction func doneButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
