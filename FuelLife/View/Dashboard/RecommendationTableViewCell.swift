//
//  RecommendationTableViewCell.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/8/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    
    let recommendationEntertainments = EntertainmentRepository.fetchRecommendationEntertainments()
    
    override func awakeFromNib() {
        let recommendationCollectionViewLayout = UICollectionViewFlowLayout();

        recommendationCollectionViewLayout.itemSize = CGSize(width: 185, height: 103)
        recommendationCollectionViewLayout.scrollDirection = .horizontal

        recommendationCollectionView.collectionViewLayout = recommendationCollectionViewLayout

        recommendationCollectionView.register(RecommendationCollectionViewCell.nib(), forCellWithReuseIdentifier: RecommendationCollectionViewCell.identifier)
                
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: Recommendation Collection View Cell Extensions

//extension RecommendationTableViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: 200, height: 103)
//    }
//}

extension RecommendationTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("you tapped me")
    }
}

extension RecommendationTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendationEntertainments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.identifier, for: indexPath) as! RecommendationCollectionViewCell
        
        let recommendationEntertainment = recommendationEntertainments[indexPath.row]

        cell.configure(recommendationLabel: recommendationEntertainment.name!,
                       recommendationPrice: String(recommendationEntertainment.basePrice),
                       recommendationColor: recommendationEntertainment.color ?? "#32a852")

        return cell
    }

}
    
