//
//  ViewController.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 03/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class DashboardController: UIViewController {

    @IBOutlet weak var dashboardTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardTableView.delegate = self
        dashboardTableView.dataSource = self

    }
    
}


// MARK: Table View Extensions

extension DashboardController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRows: Int

        switch section {
        case 0:
            numberOfRows = 1
        case 1:
            numberOfRows = 1
        case 2:
            numberOfRows = 1
        case 3:
            numberOfRows = 1
        case 4:
            numberOfRows = 4
        default:
            numberOfRows = 1
        }
        
        return numberOfRows
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
            return 135 //Recommendation Cell
        case 1:
            return 127 // Dashboard Cell
        case 2:
            return 285 //Budget Cell
        case 3:
            return 430 //Expense Cell
        case 4:
            return 300 //Top Stories
        default:
            return 250
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {

            case 0, 1, 4:
                return 38
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var headerTitle: String
        
        switch section {
        case 0:
            headerTitle = "Recommendation"
        case 1:
            headerTitle = "Dashboard"
        case 4:
            headerTitle = "Top Stories"
        default:
            return nil
        }
        
        return headerTitle
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myLabel = UILabel()
        
        myLabel.frame = CGRect(x: 11, y: 8, width: 320, height: 30)
        myLabel.font = UIFont(name: "HelveticaNeue-Bold", size:  22.0)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let headerView = UIView()
        headerView.addSubview(myLabel)
           
        return headerView
    }
    
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let category = categories[indexPath.row]
        //        performSegue(withIdentifier: "productVC", sender: category)
    }
    

}






