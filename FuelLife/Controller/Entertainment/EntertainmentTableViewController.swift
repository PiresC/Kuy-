//
//  EntertainmentTableViewController.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/10/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class EntertainmentTableViewController: UITableViewController {
    
    let entertainments = EntertainmentRepository.fetchEntertainments()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entertainments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntertainmentPreferenceTableViewCell", for: indexPath) as! EntertainmentPreferenceTableViewCell

        cell.entertainment = entertainments[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editEntertainmentSegue", sender: entertainments[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editEntertainmentSegue" {
            let editEntertainmentController = segue.destination as! EditEntertainmentViewController
            editEntertainmentController.entertainment = sender as? Entertainment
        }
    }
    
  
}
