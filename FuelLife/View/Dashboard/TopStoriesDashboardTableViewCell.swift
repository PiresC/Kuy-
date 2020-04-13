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
    var url: String?
    var count: Int = 0
    var share: [String]? = []
    var shareUrl: String?
    
    var dashboardView: DashboardController?
    
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
    
    @IBAction func shareButton(_ sender: UIButton) {
        let secondActivityItem: URL = URL(string: url ?? "http://www.apple.com")!
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [secondActivityItem], applicationActivities: nil)

        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToTwitter, UIActivity.ActivityType.addToReadingList]

        dashboardView?.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func openWebsiteButton(_ sender: UIButton) {
        //okee contoh yaak misalnya https://www.nytimes.com/2020/04/12/podcasts/the-daily/weird-al-yankovic-coronavirus-music.html
        
        UIApplication.shared.open(URL(string: url ?? "http://www.apple.com")!, options: [:], completionHandler: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
