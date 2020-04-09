//
//  ChartView.swift
//  FuelLife
//
//  Created by Amos Ebenhaezer on 08/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

struct fgBackground {
    var strokeColor: CGColor
    var strokeStart: CGFloat
    var strokeEnd: CGFloat
}

struct chartValue {
    var pieValue: String
    var persentase: String
}

private var backgroundLayer: CAShapeLayer!
private var foregroundLayers: [CAShapeLayer?] = []
private var chartValues: [String] = []

private var textLayer: CATextLayer!
private var chartText: String = ""

class ChartImageView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    init(frame: CGRect, text: String, fgBackground: [fgBackground]) {
        super.init(frame: frame)
        
        let width = frame.width
        let height = frame.height
        
        let lineWidth = 0.1 * min(width, height)
        
        chartText = text
        
//        chartText = chartValues[chartValue]

//        let persentase: Float = (chartText as NSString).floatValue / 100
        print(fgBackground)
        
        let startAngle: CGFloat = -CGFloat.pi / 2
        let endAngle: CGFloat = startAngle + 2 * CGFloat.pi
        let fillColor: CGColor = UIColor.clear.cgColor
        
        backgroundLayer = createCircularLayer(rect: frame, startAngle: startAngle, endAngle: endAngle, strokeColor: UIColor.lightGray.cgColor, fillColor: fillColor, lineWidth: lineWidth)
        
        
        textLayer = createTextLayer(rect: frame, textColor: UIColor.black.cgColor, text: chartText)
        
        layer.addSublayer(backgroundLayer)
        
        for fgBackgroundCount in 0...fgBackground.count-1 {
            let forebackgroundLayer = createCircularLayer(rect: frame, startAngle: startAngle, endAngle: endAngle, strokeColor: fgBackground[fgBackgroundCount].strokeColor, fillColor: fillColor, lineWidth: lineWidth)
            forebackgroundLayer.strokeStart = fgBackground[fgBackgroundCount].strokeStart
            forebackgroundLayer.strokeEnd = fgBackground[fgBackgroundCount].strokeEnd
            foregroundLayers.append(forebackgroundLayer)
//            layer.addSublayer(test)
        }
        
        layer.addSublayer(textLayer)
    }
        
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func draw(_ rect: CGRect) {
        layer.addSublayer(backgroundLayer!)
        for foregroundLayer in foregroundLayers {
            layer.addSublayer(foregroundLayer!)
        }
        layer.addSublayer(textLayer)
    }
    
    func createCircularLayer(rect: CGRect, startAngle: CGFloat, endAngle: CGFloat, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
            
            let width = rect.width
            let height = rect.height
            
            let lineWidth = 0.1 * min(width, height)
                    
            let center = CGPoint(x: width / 2, y: height / 2)
            let radius = (min(width, height) - lineWidth) / 2
            
            
            let startAngle = startAngle
            let endAngle = endAngle
            
            let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

            let shapeLayer = CAShapeLayer()

            shapeLayer.path = circularPath.cgPath

            shapeLayer.strokeColor = strokeColor
            shapeLayer.fillColor = fillColor
            shapeLayer.lineWidth = lineWidth
            shapeLayer.lineCap = .round

            return shapeLayer
        }
        
        func createTextLayer(rect: CGRect, textColor: CGColor, text: String) -> CATextLayer {
            let width = rect.width
            let height = rect.height
            
            let fontSize = min(width, height) / 4
            let offSet = min(width, height) * 0.1
            
            let layer = CATextLayer()
            layer.string = text
            layer.backgroundColor = UIColor.clear.cgColor
            layer.foregroundColor = textColor
            layer.fontSize = fontSize
            layer.frame = CGRect(x: 0, y: (height - fontSize - offSet) / 2, width: width, height: fontSize + offSet)
            layer.alignmentMode = .center
            
            return layer
        }

}
