//
//  PreferenceTableViewController.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/11/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class PreferenceTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 1) {
            
            let alert = UIAlertController(title: "Reset Budget", message: "Are you sure you want to reset budget?", preferredStyle: .alert)
            
            let actionForYes = UIAlertAction(title: "Yes", style: .default) { (action) in
                
                let period = PeriodRepository.getCurrentPeriod()
                
                print("Budget was reseted. Budget before: \(period?.currentBudget ?? 0)")
                PeriodRepository.resetBudget()
                print("Budget was reseted. Budget now: \(period?.currentBudget ?? 0)")
            }
            
            let actionForNo = UIAlertAction(title: "No", style: .default) { (action) in
            }
                       
            alert.addAction(actionForNo)
            alert.addAction(actionForYes)
            present(alert, animated: true, completion: nil)
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
