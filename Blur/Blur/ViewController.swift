//
//  ViewController.swift
//  Blur
//
//  Created by Origheart on 16/9/10.
//  Copyright © 2016年 Horizon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var blurView: DynamicBlurView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        blurView.blurRadius = 15
    }
    
    
    @IBAction func save(sender: UIButton) {
        
        UIGraphicsBeginImageContextWithOptions(self.blurView.bounds.size, true, 0)
        self.blurView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        NSFileManager.defaultManager().createFileAtPath("/Users/51offer/Desktop/blur.png", contents: UIImagePNGRepresentation(image), attributes: nil)
    
    }
}

