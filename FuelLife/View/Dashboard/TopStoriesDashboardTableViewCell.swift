//
//  TopStoriesDashboardTableViewCell.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/8/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class TopStoriesDashboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topStoriesView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    
    var count: Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topStoriesView.layer.cornerRadius = 10
        topStoriesView.layer.borderWidth = 0.4
        topStoriesView.layer.borderColor = UIColor.lightGray.cgColor
        
        topStoriesView.layer.shadowColor = UIColor.gray.cgColor
        topStoriesView.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        topStoriesView.layer.shadowRadius = 2.0
        topStoriesView.layer.shadowOpacity = 0.7
        topStoriesView.layer.masksToBounds = false
    }
    
    @IBAction func openWebsiteButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://www.apple.com")!, options: [:], completionHandler: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
