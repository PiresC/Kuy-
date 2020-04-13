//
//  BudgetChartTableViewCell.swift
//  FuelLife
//
//  Created by Edwin Sendjaja on 4/8/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

class BudgetChartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var budgetChartView: UIView!
    @IBOutlet weak var budgetLabelView: BudgetChartTableViewCell!
    
    
    var strokeColor: [CGColor] = []
    var strokeStart: CGFloat = 0.0
    var strokeEnd: CGFloat = 0.0
    var frames: CGRect = CGRect(x: 0, y: 0, width: 150, height: 150)
    var persentase: String = ""
    var test: String = ""
    var count: Int = 0
    
    //    var data: [fgBackground] = []
    var arrText: [String] = []
    
    func updateView(){
        var temp = 0.0
        var count = 0
        var totalPercentage = 0
        for a in EntertainmentRepository.getEntertainmentReport(){
            if a.percentage != 0 && count<4{
                totalPercentage += a.percentage
                let color = UIColor(hexString: a.backgroundColor).cgColor
                let decimalPercentage =  Double(a.percentage)/100
                setChart(frame: frames, text: "\(totalPercentage)%", strokeColor: color, strokeStart: CGFloat(temp), strokeEnd: CGFloat(decimalPercentage + temp))
                temp += decimalPercentage
                count+=1
                
                arrText.append(a.name)
                strokeColor.append(UIColor(hexString: a.backgroundColor).cgColor)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        persentase = "80%"
        test = "check"
        
        updateView()
        
        
        setLabel(textLabel: arrText)
        
        budgetChartView?.layer.cornerRadius = 10
        budgetChartView?.layer.borderWidth = 0.4
        budgetChartView?.layer.borderColor = UIColor.lightGray.cgColor
        
        budgetChartView?.layer.shadowColor = UIColor.gray.cgColor
        budgetChartView?.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        budgetChartView?.layer.shadowRadius = 2.0
        budgetChartView?.layer.shadowOpacity = 0.7
        budgetChartView?.layer.masksToBounds = false
    }
    
    func setChart(frame: CGRect, text: String, strokeColor: CGColor, strokeStart: CGFloat, strokeEnd: CGFloat) {
        _ = ChartImageView(frame: frame, text: text, fgBackground: [fgBackground(strokeColor: strokeColor, strokeStart: strokeStart, strokeEnd: strokeEnd)])
        count += 1
    }
    
    func setLabel(textLabel: [String]) {
        var initY = 9.0
        for i in 0..<count {
            let chartLabel = UILabel(frame: CGRect(x: 54.0, y: initY, width: 115.0, height: 21.0))
            
            let chartColor = UIView(frame: CGRect(x: 30.0, y: initY, width: 20.0, height: 21.0))
            
            chartColor.backgroundColor = UIColor(cgColor: strokeColor[i])
            chartLabel.text = textLabel[i]
            
            initY += Double(chartLabel.frame.size.height) + 9
            
            budgetLabelView?.addSubview(chartColor)
            budgetLabelView?.addSubview(chartLabel)
        }
        print(count)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
