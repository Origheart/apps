//
//  AppDelegate.swift
//  SpotIt
//
//  Created by 刘康 on 16/9/8.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // 传递 user activity 对象
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
        let viewController = (window?.rootViewController as! UINavigationController).viewControllers[0] as! ViewController
        viewController.restoreUserActivityState(userActivity)
        
        return true
    }
    
}