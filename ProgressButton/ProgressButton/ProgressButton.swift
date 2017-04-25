//
//  ProgressButton.swift
//  ProgressButton
//
//  Created by Origheart on 2017/4/25.
//  Copyright © 2017年 origheart. All rights reserved.
//

import UIKit

@IBDesignable class ProgressButton: UIButton {

    private var progressLayer: CALayer = CALayer()
    
    @IBInspectable var progressColor: UIColor = #colorLiteral(red: 0.3529411765, green: 0.5647058824, blue: 0.8666666667, alpha: 1) {
        didSet {
            progressLayer.backgroundColor = progressColor.cgColor
        }
    }
    
    var progress: CGFloat = 0.0 {
        didSet {
            progressLayer.frame = CGRect(x: 0, y: 0, width: bounds.width * progress, height: bounds.height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    
    func setupLayer() {
        progressLayer.frame = CGRect(x: 0, y: 0, width: 0, height: bounds.height)
        progressLayer.backgroundColor = progressColor.cgColor
        layer.addSublayer(progressLayer)
        
        backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        setTitleColor(UIColor.white, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
    }

}
