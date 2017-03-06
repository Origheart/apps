//
//  CounterView.swift
//  CoreGraphicsDemo
//
//  Created by Origheart on 2017/3/2.
//  Copyright © 2017年 origheart. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let π: CGFloat = CGFloat(M_PI)

@IBDesignable class CounterView: UIView {
    
    @IBInspectable var counter: Int = 5 {
        didSet {
            if counter <= NoOfGlasses {
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius:CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = 76
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius / 2 - arcWidth / 2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        path.lineWidth = arcWidth
        
        counterColor.setStroke()
        path.stroke()
        
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width / 2 - 2.5,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        outlinePath.addArc(withCenter: center,
                           radius: bounds.width / 2 - arcWidth + 2.5,
                           startAngle: outlineEndAngle,
                           endAngle: startAngle,
                           clockwise: false)
        
        outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
    }
    

}
