//
//  ViewController.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 03/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dashboardTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardTableView.delegate = self
        dashboardTableView.dataSource = self
    }
    
}


// MARK: Table View Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var identifier: String
        
        switch indexPath.section {
        case 0:
            identifier = "recommendationTableViewCell"
        case 1:
            identifier = "dashboardTableViewCell"
        case 2:
            identifier = "budgetTableViewCell"
        case 3:
            identifier = "expenseTableViewCell"
        case 4:
            identifier = "topStoriesTableViewCell"
        default:
            identifier = "topStoriesTableViewCell"
        }
          
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
                //let category = categories[indexPath.row]
                
                //cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        //        cell.textLabel?.text = category.categoryName
        //        cell.detailTextLabel?.text = category.categoryDescription
        //        cell.imageView?.image = UIImage(named: category.categoryImage)
        //        recommendationCellLabel.text = recommendationLabel
        //          recommendationCellPrice?.text = recommendationPrice
                            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 197
        case 1:
            return 211
        case 2:
            return 285
        case 3:
            return 221
        case 4:
            return 324
        default:
            return 300
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let category = categories[indexPath.row]
        //        performSegue(withIdentifier: "productVC", sender: category)
    }
    

}






