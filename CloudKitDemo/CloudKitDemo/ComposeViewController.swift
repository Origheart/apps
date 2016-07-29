//
//  ComposeViewController.swift
//  CloudKitDemo
//
//  Created by 刘康 on 16/7/28.
//  Copyright © 2016年 刘康. All rights reserved.
//

import UIKit

let locationHelper: LocationHelper = LocationHelper()

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var titleTextFeild: UITextField!
    @IBOutlet weak var contentTextFeild: UITextField!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    var diary:Diary = Diary()
    
    @IBAction func save(sender: AnyObject) {
        debugPrint("save...")
        diary.title = titleTextFeild.text
        diary.content = contentTextFeild.text!
        diary.id = randomStringWithLength(32) as String
        if nil == locationHelper.address {
            diary.location = "上海"
        }
        saveNewRecord(diary)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserverForName("UserLocationUpdated", object: nil, queue: nil) { (noti) in
            if let address = locationHelper.address {
                self.diary.location = address
                
                debugPrint("Author at \(address)")
                
                if let _ = self.diary.location {
                    self.locationLabel.text = self.diary.location
                }else {
                    self.locationLabel.text = "于 \(address)"
                }
                
                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations:
                    { [weak self] in
                        self?.locationLabel.alpha = 1.0
                        
                    }, completion: nil)
                
                locationHelper.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        titleTextFeild.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }


}
