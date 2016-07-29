//
//  WeiboHeader.swift
//  CustomizeXibView
//
//  Created by Origheart on 16/7/15.
//  Copyright © 2016年 Origheart. All rights reserved.
//

import UIKit

class WeiboHeader: UIView {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderIcon: UIImageView!
    @IBOutlet weak var followNumLabel: UILabel!
    @IBOutlet weak var fansNumLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var view: UIView!
    
    @IBInspectable var background: UIImage? {
        get {
            return backgroundImageView.image
        }
        set {
            backgroundImageView.image = newValue
        }
    }
    
    @IBInspectable var avatar: UIImage? {
        get {
            return avatarImageView.image
        }
        set {
            avatarImageView.image = newValue
        }
    }
    
    @IBInspectable var name: String? {
        get {
            return nameLabel.text
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    @IBInspectable var gender: Bool {
        get {
            return false
        }
        set {
            let image = newValue ? "userinfo_icon_male" : "userinfo_icon_female"
            genderIcon.image = UIImage(named: image)
        }
    }
    
    @IBInspectable var followCount: String? {
        get {
            return followNumLabel.text
        }
        set {
            followNumLabel.text = newValue
        }
    }
    
    @IBInspectable var fansCount: String? {
        get {
            return fansNumLabel.text
        }
        set {
            fansNumLabel.text = newValue
        }
    }
    
    @IBInspectable var desc: String? {
        get {
            return descLabel.text
        }
        set {
            descLabel.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib()
    }
    
    func setupXib() {
        view = loadViewFromNib()
        view.frame = bounds
        addSubview(view)
    }

    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "WeiboHeader", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as? UIView
        return view!
    }
    
}
