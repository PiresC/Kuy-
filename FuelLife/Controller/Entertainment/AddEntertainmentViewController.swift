//
//  AddEntertainmentViewController.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 08/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class AddEntertainmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    struct Color {
        var color:UIColor
        var name:String
        var hex:String
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var selectedColorLabel: UIView!
    @IBOutlet weak var colorLabel: UITextField!
    
    var addExpenseViewController:AddExpenseViewController?
    var editExpenseViewController:EditExpenseViewController?
    
    var colors = [Color(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), name: "Biru", hex: "#3802DA"), Color(color: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), name: "Merah", hex: "#92003B"), Color(color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), name: "Kuning", hex: "#F3AF22")]
    var selectedColor:Color?
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        picker.delegate = self
        picker.dataSource = self
        
        selectedColorLabel.layer.cornerRadius = 10
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(onSelectColor))
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spacer,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        colorLabel.inputView = picker
        colorLabel.inputAccessoryView = toolBar
        
    }
    
    func updateView(){
        if let name = nameLabel.text, let price = priceLabel.text, let color = selectedColor{
            selectedColorLabel.backgroundColor = color.color
            if (!name.isEmpty && !price.isEmpty){
                saveButton.isEnabled = true
            }
        }
    }
    
    @objc func onSelectColor(){
        selectedColor = colors[picker.selectedRow(inComponent: 0)]
        updateView()
        view.endEditing(true)
    }
    
    @IBAction func nameLabelChanged(_ sender: Any) {
        updateView()
    }
    
    
    @IBAction func priceLabelChanged(_ sender: Any) {
        updateView()
    }
    
    @IBAction func cancelButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClick(_ sender: Any) {
        dismiss(animated: true){
            _ = EntertainmentRepository.createEntertainment(name: self.nameLabel.text!, basePrice: Int64(self.priceLabel.text!)!, color: self.selectedColor!.hex)
            if let vc = self.addExpenseViewController{
                vc.updateView()
            }
            else if let vc = self.editExpenseViewController{
                vc.updateView()
            }
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        let parentView = UIView()
        let label = UILabel(frame: CGRect(x: 60, y: 5, width: 80, height: 40))
        let imageView = UIView(frame: CGRect(x: 0, y: 5, width: 40, height:40))
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = colors[row].color
        label.text = colors[row].name
        parentView.addSubview(label)
        parentView.addSubview(imageView)
        
        return parentView
    }
    
}
