//
//  ViewController.swift
//  PrintLog
//
//  Created by 刘康 on 16/8/31.
//  Copyright © 2016年 刘康. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        printLog("view did load")
        method()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func method() {
        printLog("this is a method")
    }

}

