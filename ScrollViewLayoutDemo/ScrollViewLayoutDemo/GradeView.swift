//
//  GradeView.swift
//  ScrollViewLayoutDemo
//
//  Created by Origheart on 2017/7/5.
//  Copyright © 2017年 origheart. All rights reserved.
//

import UIKit

class GradeView: UIView {

    lazy var avatar: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "avatar"))
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Lisa"
        label.textAlignment = .center
        return label
    }()
    
    lazy var jobLabel: UILabel = {
        let label = UILabel()
        label.text = "服务顾问"
        label.textAlignment = .center
        return label
    }()
    
    var expands = false
    
    var textList = ["The UIScrollView has solid constraints, e.g., 50 px from every side (no problem). Then I add a Top Space constraint to the UILabel (no problem) ",
                    "I did this minimal example in a freshly new project which you can download and I ",
                    "When I run the App without updating the ",
                    "When I run the App without updating the Label's frame as suggested by IB it is positioned just fine, exactly where it's supposed to be and the UIScrollView is scrollable. If I DO update the frame the Label is out of sight and the UIScrollView does not scroll."]
    
    var button: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("展开/收起", for: .normal)
        btn.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return btn
    }()
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "detail"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    @objc func buttonTap() {
        let index = Int(arc4random())%textList.count
        detailLabel.text = textList[index]
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    func setupSubviews() {
        addSubview(avatar)
        avatar.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatar.snp.bottom).offset(20)
        }
        
        addSubview(jobLabel)
        jobLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
        
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(jobLabel.snp.bottom).offset(30)
        }
        
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(button.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        snp.makeConstraints { (make) in
            make.bottom.equalTo(detailLabel.snp.bottom)
        }
    }
}
