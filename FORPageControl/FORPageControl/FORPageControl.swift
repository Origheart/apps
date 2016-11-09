//
//  FORPageControl.swift
//  FORPageControl
//
//  Created by Origheart on 2016/10/9.
//  Copyright © 2016年 origheart. All rights reserved.
//

import UIKit

@IBDesignable open class FORPageControl: UIView {
    
    // MARK: - PageControl
    
    @IBInspectable open var pageCount: Int = 0 {
        didSet {
            updateNumberOfPages(pageCount)
        }
    }
    @IBInspectable open var progress: CGFloat = 0 {
        didSet {
            layoutActivePageIndicator(progress)
        }
    }
    open var currentPage: Int {
        return Int(round(progress))
    }
    
    // MARK: - Appearance
    
    @IBInspectable open var activeTint: UIColor = UIColor.white {
        didSet {
            activeLayer.backgroundColor = activeTint.cgColor
        }
    }
    @IBInspectable open var inactiveTint: UIColor = UIColor(white: 1, alpha: 0.3) {
        didSet {
            inactiveLayers.forEach() {
                $0.backgroundColor = inactiveTint.cgColor
            }
        }
    }
    @IBInspectable open var indicatorPadding: CGFloat = 8 {
        didSet {
            layoutInactivePageIndicators(inactiveLayers)
        }
    }
    @IBInspectable open var indicatorSideLength: CGFloat = 8 {
        didSet {
            layoutInactivePageIndicators(inactiveLayers)
        }
    }
    
    fileprivate var indicatorHeight: CGFloat {
        return indicatorSideLength * 1.3
    }
    fileprivate var inactiveLayers = [CALayer]()
    fileprivate lazy var activeLayer: CALayer = { [unowned self] in
        let layer = CALayer()
        layer.frame = CGRect(origin: CGPoint.zero,
                             size: CGSize(width: self.indicatorSideLength, height: self.indicatorHeight))
        layer.backgroundColor = self.activeTint.cgColor
        layer.actions = [
            "bounds": NSNull(),
            "frame": NSNull(),
            "position": NSNull()]
        return layer
    }()
    
    open override var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize.zero)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: CGFloat(inactiveLayers.count) * indicatorSideLength + CGFloat(inactiveLayers.count - 1) * indicatorPadding,
                      height: indicatorHeight)
    }
}

fileprivate extension FORPageControl {
    
    // MARK: - State Update
    
    func updateNumberOfPages(_ count: Int) {
        // no need to update
        guard count != inactiveLayers.count else {
            return
        }
        // reset current layout
        inactiveLayers.forEach { (layer) in
            layer.removeFromSuperlayer()
        }
        inactiveLayers = [CALayer]()
        // add layers for new page count
        inactiveLayers = stride(from: 0, to: count, by: 1).map() { _ in
            let layer = CALayer()
            layer.backgroundColor = self.inactiveTint.cgColor
            self.layer.addSublayer(layer)
            return layer
        }
        layoutInactivePageIndicators(inactiveLayers)
        // ensure active page indicator is on top
        self.layer.addSublayer(activeLayer)
        layoutActivePageIndicator(progress)
        self.invalidateIntrinsicContentSize()
    }
    
    // MARK - Layout
    
    func layoutActivePageIndicator(_ progress: CGFloat) {
        // ignore if progress is outside of page indicators' bounds
        guard progress >= 0 && progress <= CGFloat(pageCount - 1) else {
            return
        }
        let denormalizedProgress = progress * (indicatorSideLength + indicatorPadding)
        let distanceFromPage = abs(round(progress) - progress)
        var newFrame = activeLayer.frame
        let widthMultiplier = (1 + distanceFromPage * 2)
        newFrame.origin.x = denormalizedProgress
        newFrame.size.width = indicatorSideLength * widthMultiplier
        activeLayer.frame = newFrame
    }
    
    func layoutInactivePageIndicators(_ layers: [CALayer]) {
        var layerFrame = CGRect(x: 0, y: indicatorHeight * (1 - indicatorSideLength / indicatorHeight), width: indicatorSideLength, height: indicatorSideLength)
        layers.forEach() { layer in
            layer.frame = layerFrame
            layerFrame.origin.x += indicatorSideLength + indicatorPadding
        }
    }
    
}

