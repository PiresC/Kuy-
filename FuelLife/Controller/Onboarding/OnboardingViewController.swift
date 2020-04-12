//
//  OnboardingViewController.swift
//  FuelLife
//
//  Created by Arie May Wibowo on 09/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit


class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    
    var imagePreferences: [String] = ["popcorn-col", "travel-col", "shopping-col", "guitar-col", "controller-col", "soccer-col"]
    var imageUnchoosen: [String] = ["popcorn", "travel", "supermarket", "guitar", "controller", "soccer"]
    var titlePreferences: [String] = ["Bioskop", "Traveling", "Shopping", "Music", "Game", "Sport"]
    var colorPreferences: [UIColor] = [UIColor.green, UIColor.orange, UIColor.blue, UIColor.red]
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    let cellIdentifier = PreferencesOnboardingCell.identifier

    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    var titles: [String] = ["Enjoy Life", "Budget Friendly", "Choose you preference"]
    var descriptions = ["life is short, do something about it", "entertainment that you can do, with your own budget", ""]
    var images = ["theater", "wallet", "theater"]
    
    var collectionView: UICollectionView?
    
    var preferenceRecommendation = [String]()
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        self.nextButton.isHidden = true
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let txt1 = UILabel.init(frame: CGRect(x:32,y:78,width:scrollWidth-64,height:100))
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        self.collectionView = UICollectionView.init(frame: CGRect(x: 0, y: txt1.frame.maxY+40, width: scrollWidth, height: 500), collectionViewLayout: layout)
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.register(PreferencesOnboardingCell.nib(), forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView?.backgroundColor = UIColor.white
        
        for index in 0..<titles.count {
            if index < 2 {
                frame.origin.x = scrollWidth * CGFloat(index)
                  frame.size = CGSize(width: scrollWidth, height: scrollHeight)

                  let slide = UIView(frame: frame)

                  //subviews
                  let imageView = UIImageView.init(image: UIImage.init(named: images[index]))
                  imageView.frame = CGRect(x:0,y:0,width:300,height:300)
                  imageView.contentMode = .scaleAspectFit
                  imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
                
                  let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+71,width:scrollWidth-64,height:50))
                  txt1.textAlignment = .center
                  txt1.font = UIFont.boldSystemFont(ofSize: 36.0)
                  txt1.text = titles[index]

                  let txt2 = UILabel.init(frame: CGRect(x:32,y:txt1.frame.maxY+12,width:scrollWidth-64,height:100))
                  txt2.textAlignment = .center
                  txt2.numberOfLines = 3
                  txt2.font = UIFont.systemFont(ofSize: 24.0)
                  txt2.text = descriptions[index]

                  slide.addSubview(imageView)
                  slide.addSubview(txt1)
                  slide.addSubview(txt2)
                  scrollView.addSubview(slide)
            } else {
                frame.origin.x = scrollWidth * CGFloat(index)
                frame.size = CGSize(width: scrollWidth, height: scrollHeight)
                let slide = UIView(frame: frame)

                  //subviews
                txt1.textAlignment = .center
                txt1.numberOfLines = 3
                txt1.font = UIFont.boldSystemFont(ofSize: 36.0)
                txt1.text = titles[index]
                
                slide.addSubview(txt1)
                slide.addSubview(self.collectionView!)
                scrollView.addSubview(slide)

            }
            

        }

        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

        self.scrollView.contentSize.height = 1.0

        //initial state
        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0
        
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }

    @IBAction func toDashboard(_ sender: UIButton) {
        UserDefaults.standard.set(preferenceRecommendation, forKey: "preferedRecommendation")
        UserDefaults.standard.set(false, forKey: "firstComer")
        performSegue(withIdentifier: "toDashboard", sender: nil)
    }
    

}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = (collectionView.frame.width/2.5) * 2
        let totalSpacingWidth = 20 * (2 - 1)

        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + CGFloat(totalSpacingWidth))) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PreferencesOnboardingCell
        cell.configure(image: imageUnchoosen[indexPath.item], title: titlePreferences[indexPath.item], color: colorPreferences[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        doSomethingWhenItemClicked(indexPath)
        if preferenceRecommendation.count > 0 {
            self.nextButton.isHidden = false
        } else {
            self.nextButton.isHidden = true
        }
    }
    
    func doSomethingWhenItemClicked(_ indexPath: IndexPath) -> Void {
        if !preferenceRecommendation.contains(titlePreferences[indexPath.item]) {
            preferenceRecommendation.append(titlePreferences[indexPath.item])
        } else {
            if let itemToRemoveIndex = preferenceRecommendation.firstIndex(of: titlePreferences[indexPath.item]) {
                preferenceRecommendation.remove(at: itemToRemoveIndex)
            }
        }
    }
    
}
