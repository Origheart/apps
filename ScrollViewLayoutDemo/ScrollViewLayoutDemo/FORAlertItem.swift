//
//  FORPopupItem.swift
//  FORPopupView
//
//  Created by Origheart on 2016/11/1.
//  Copyright © 2016年 origheart. All rights reserved.
//

import UIKit

class FORAlertItem: NSObject {
    var title: String?
    var detail: String?
    var image: String?
    var actions: [FORAlertAction]?
    var grade: String?
}

@objc public enum FORAlertActionStyle : Int {
    case `default`
    case highlight
}

@objc public class FORAlertAction: NSObject {
    public convenience init(title: String?, style: FORAlertActionStyle, handler: ((FORAlertAction) -> Void)?) {
        self.init()
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    override init() {
        self.style = .default
        super.init()
    }
    
    var title: String?
    var style: FORAlertActionStyle
    var handler: ((FORAlertAction) -> Void)?
}
