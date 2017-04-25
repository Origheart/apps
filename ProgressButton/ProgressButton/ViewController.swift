//
//  ViewController.swift
//  ProgressButton
//
//  Created by Origheart on 2017/4/25.
//  Copyright © 2017年 origheart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressButton: ProgressButton!

    @IBAction func slide(_ sender: UISlider) {
        progressButton.progress = CGFloat(sender.value)
    }

}

