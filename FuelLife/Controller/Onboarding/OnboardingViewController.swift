//
//  OnboardingViewController.swift
//  FuelLife
//
//  Created by Arie May Wibowo on 09/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class PreferencesCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
        addSubview(imgView)
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imgView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "travel.png")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}

class OnboardingViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagePreferences.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PreferencesCell
        cell.imgView.image = UIImage(named: imagePreferences[indexPath.row])
        return cell
    }
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let cellIdentifier = "preferenceCell"

    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    var titles: [String] = ["Enjoy Life", "Budget Friendly", "Choose you preference"]
    var descriptions = ["life is short, do something about it", "entertainment that you can do, with your own budget", ""]
    var imagePreferences = ["popcorn", "supermarket", "fish", "travel"]
    var images = ["theater", "wallet", "theater"]
    
    var prefCollectionView: UICollectionView
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let txt1 = UILabel.init(frame: CGRect(x:32,y:78,width:scrollWidth-64,height:100))
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 60, height: 60)
        
//        prefCollectionView = UICollectionView.init(frame: CGRect(x: 30, y: txt1.frame.maxY+20, width: 150, height: 200), collectionViewLayout: layout)
        
        collectionView.register(PreferencesCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
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
                slide.addSubview(prefCollectionView ?? UICollectionView())
                scrollView.addSubview(slide)
            }
            

        }

        //set width of scrollview to accomodate all the slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

        //disable vertical scroll/bounce
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


}
