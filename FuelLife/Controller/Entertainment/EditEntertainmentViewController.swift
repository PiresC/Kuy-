//
//  EditEntertainmentViewController.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 09/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class EditEntertainmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var selectedColorLabel: UIView!
    @IBOutlet weak var colorLabel: UITextField!
    
    var tableViewDelegate: RefreshDataDelegate?

    var entertainment:Entertainment?
    
    var colors = ["#FF0028", "#a4cf00", "#ff00ff", "#f2d53c", "#ffc0cb","#ffa500", "#d2b48c", "#c0c0c0"]
    var selectedColor:String?
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        picker.delegate = self
        picker.dataSource = self
        
        selectedColorLabel.layer.cornerRadius = 10
        
        if let e = entertainment{
            selectedColor = e.color
            priceLabel.text = "\(e.basePrice)"
            nameLabel.text = e.name
            updateView()
        }
        
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
            selectedColorLabel.backgroundColor = UIColor(hexString: color)
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
            _ = EntertainmentRepository.updateEntertainment(entertainment: self.entertainment!, newName: self.nameLabel.text!, newBasePrice: Int64(self.priceLabel.text!)!, newColor: self.selectedColor!)
            
            self.tableViewDelegate!.refreshData()

        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
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
        imageView.backgroundColor = UIColor(hexString: colors[row])
        label.text = colors[row]
        parentView.addSubview(label)
        parentView.addSubview(imageView)
        
        return parentView
    }
}
