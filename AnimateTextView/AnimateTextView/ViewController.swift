//
//  ViewController.swift
//  AnimateTextView
//
//  Created by Origheart on 2017/5/4.
//  Copyright © 2017年 origheart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animateTextView: AnimateTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func animate(_ sender: UIButton) {
        animateTextView.textList = ["开始筛选案例", "英国 硕士", "北京大学", "电子信息工程专业", "筛选完成"]
        animateTextView.animate(duration: 5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

