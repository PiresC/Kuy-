//
//  ChartView.swift
//  FuelLife
//
//  Created by Amos Ebenhaezer on 08/04/20.
//  Copyright © 2020 Team 10. All rights reserved.
//

import UIKit

private var backgroundLayer: CAShapeLayer!
private var foregroundLayers: [CAShapeLayer?] = []

private var foregroundLayer1: CAShapeLayer!
private var foregroundLayer2: CAShapeLayer!
private var foregroundLayer3: CAShapeLayer!
private var foregroundLayer4: CAShapeLayer!

private var textLayer: CATextLayer!
private var chartText: String = ""

class ChartView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let lineWidth = 0.1 * min(width, height)
        
        var chartText: String = "30%"
        let persentase: Float = (chartText as NSString).floatValue / 100
        print(persentase)
        
        backgroundLayer = createCircularLayer(rect: rect, startAngle: -CGFloat.pi / 2, endAngle: (-CGFloat.pi / 2) + 2 * CGFloat.pi, strokeColor: UIColor.lightGray.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        
        foregroundLayer1 = createCircularLayer(rect: rect, startAngle: -CGFloat.pi / 2, endAngle: (-CGFloat.pi / 2) + 2 * CGFloat.pi, strokeColor: UIColor.red.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        foregroundLayer1.strokeEnd = CGFloat(persentase)
        
        
        foregroundLayers.append(foregroundLayer1)
        
        foregroundLayer2 = createCircularLayer(rect: rect, startAngle: -CGFloat.pi / 2, endAngle: (-CGFloat.pi / 2) + 2 * CGFloat.pi, strokeColor: UIColor.blue.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        foregroundLayer2.strokeStart = CGFloat(persentase)
        foregroundLayer2.strokeEnd = CGFloat(persentase + 0.2)
        
        foregroundLayers.append(foregroundLayer2)
        
        layer.addSublayer(backgroundLayer)
        for foregroundLayer in foregroundLayers {
            layer.addSublayer(foregroundLayer!)
        }
        textLayer = createTextLayer(rect: rect, textColor: UIColor.black.cgColor, text: chartText)
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
