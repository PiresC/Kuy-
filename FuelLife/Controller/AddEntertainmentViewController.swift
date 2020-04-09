//
//  AddEntertainmentViewController.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 08/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class AddEntertainmentViewController: UIViewController {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var selectedColor: UIView!
    @IBOutlet weak var colorLabel: UITextField!
    
    var addExpenseViewController:AddExpenseViewController?
    var editExpenseViewController:EditExpenseViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClick(_ sender: Any) {
        dismiss(animated: true){
            if let vc = self.addExpenseViewController{
                vc.updateView()
            }
            else if let vc = self.editExpenseViewController{
                vc.updateView()
            }
        }
    }
    
    
}
