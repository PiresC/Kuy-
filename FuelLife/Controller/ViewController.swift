//
//  ViewController.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 03/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class RecommendationViewCell: UITableViewCell {
    
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    
    override func awakeFromNib() {
//        let recommendationCollectionViewLayout = UICollectionViewFlowLayout();
//        
//        recommendationCollectionViewLayout.itemSize = CGSize(width: 120, height: 120)
//        recommendationCollectionViewLayout.scrollDirection = .horizontal
//        
//        recommendationCollectionView.collectionViewLayout = recommendationCollectionViewLayout
//        
//        recommendationCollectionView.register(RecommendationCollectionViewCell.nib(), forCellWithReuseIdentifier: RecommendationCollectionViewCell.identifier)
        
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var dashboardTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardTableView.delegate = self
        dashboardTableView.dataSource = self
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        "Section ABC"
//    }
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
                //cell.recommen
                
                return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 186
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


extension RecommendationViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 120)
    }
    
}

extension RecommendationViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("you tapped me")
    }
}

extension RecommendationViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.identifier, for: indexPath) as! RecommendationCollectionViewCell
        
        cell.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.5960784314, alpha: 1) 

        //cell.configure(recommendationLabel: "Movie", recommendationPrice: "$ 100")
        return cell
    }

}


