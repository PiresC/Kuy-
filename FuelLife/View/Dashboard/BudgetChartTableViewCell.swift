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
    
    var arrText: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        persentase = "80%"
        test = "check"
        
        strokeColor.append(UIColor.red.cgColor)
        strokeColor.append(UIColor.blue.cgColor)
        
        setChart(frame: frames, text: persentase, strokeColor: strokeColor[0], strokeStart: 0.0, strokeEnd: 0.2)
        setChart(frame: frames, text: persentase, strokeColor: strokeColor[1], strokeStart: 0.2, strokeEnd: 0.8)
        
        budgetChartView?.layer.cornerRadius = 10
        budgetChartView?.layer.borderWidth = 0.4
        budgetChartView?.layer.borderColor = UIColor.lightGray.cgColor
        
        budgetChartView?.layer.shadowColor = UIColor.gray.cgColor
        budgetChartView?.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        budgetChartView?.layer.shadowRadius = 2.0
        budgetChartView?.layer.shadowOpacity = 0.7
        budgetChartView?.layer.masksToBounds = false
        
        
        arrText.append("a")
        arrText.append("b")
        setLabel(textLabel: arrText)
         
    }
    
    func setChart(frame: CGRect, text: String, strokeColor: CGColor, strokeStart: CGFloat, strokeEnd: CGFloat) {
            ChartImageView(frame: frame, text: text, fgBackground: [fgBackground(strokeColor: strokeColor, strokeStart: strokeStart, strokeEnd: strokeEnd)])
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
