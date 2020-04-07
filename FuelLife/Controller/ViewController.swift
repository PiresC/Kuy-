//
//  ViewController.swift
//  FuelLife
//
//  Created by Wikan Setiaji on 03/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var recommendationCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recommendationCollectionViewLayout = UICollectionViewFlowLayout();
        
        recommendationCollectionViewLayout.itemSize = CGSize(width: 120, height: 120)
        recommendationCollectionViewLayout.scrollDirection = .horizontal
        
        recommendationCollectionView.collectionViewLayout = recommendationCollectionViewLayout
        
        recommendationCollectionView.register(RecommendationCollectionViewCell.nib(), forCellWithReuseIdentifier: RecommendationCollectionViewCell.identifier)
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 120)
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("you tapped me")
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.identifier, for: indexPath) as! RecommendationCollectionViewCell
        
        cell.backgroundColor = UIColor(hex: "#F8F798FF")

        //cell.configure(recommendationLabel: "Movie", recommendationPrice: "$ 100")
        return cell
    }

}


