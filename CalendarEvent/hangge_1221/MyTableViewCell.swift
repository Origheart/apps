//
//  MyTableViewCell.swift
//  hangge_1221
//
//  Created by hangge on 16/10/6.
//  Copyright © 2016年 hangge.com. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    //左侧分类标识
    @IBOutlet weak var sideSign: UIView!
    
    //标题标签
    @IBOutlet weak var titleLabel: UILabel!
    
    //时间标签
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
