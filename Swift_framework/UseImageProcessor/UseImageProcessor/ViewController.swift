//
//  ViewController.swift
//  UseImageProcessor
//
//  Created by 刘康 on 2016/11/17.
//  Copyright © 2016年 刘康. All rights reserved.
//

import UIKit
import ImageProcessor

class ViewController: UIViewController {
    
    var image: UIImage = #imageLiteral(resourceName: "Image")

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func tap(_ sender: UIButton) {
        
        if sender.tag == 0 {
            self.imageView.image = image
        } else if sender.tag == 1 {
            self.imageView.image = ImageProcessor(image: image).pixellated(scale: 5)
        } else {
            self.imageView.image = ImageProcessor(image: image).blured(radius: 10)
        }
        
    }
    

}

