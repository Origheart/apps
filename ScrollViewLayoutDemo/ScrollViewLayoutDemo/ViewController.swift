//
//  ViewController.swift
//  ScrollViewLayoutDemo
//
//  Created by Origheart on 2017/7/5.
//  Copyright © 2017年 origheart. All rights reserved.
//

import UIKit

let FOR_SPLIT_WIDTH: CGFloat            = (1.0 / UIScreen.main.scale)
let FOR_POPUP_WIDTH: CGFloat            = (0.8 * UIScreen.main.bounds.width)
let FOR_POPUP_TOP_PADDING: CGFloat      = 100
let FOR_IMAGE_HEIGHT: CGFloat           = 160.0
let FOR_LOADING_HEIGHT: CGFloat         = 180.0
let FOR_CORNER_RADIUS: CGFloat          = 10.0
let FOR_BUTTON_HEIGHT: CGFloat          = 50.0
let FOR_SCREEN_SIZE: CGSize             = UIScreen.main.bounds.size
let FOR_INNER_MARGIN: CGFloat           = 25.0
let FOR_TEXT_PADDING: CGFloat           = 4.0

let FOR_SPLIT_COLOR: UInt               = 0xCCCCCCFF
let FOR_BUTTON_HIGHLIGHT_COLOR: UInt    = 0x28a0f2
let FOR_BUTTON_NORMAL_COLOR: UInt       = 0x010101
let FOR_TITLE_COLOR: UInt               = 0x333333
let FOR_DETAIL_COLOR: UInt              = 0x000000

let FOR_TITLE_FONT: CGFloat             = 18.0
let FOR_DETAIL_FONT: CGFloat            = 14.0


class ViewController: UIViewController {

    fileprivate var detailLabelHeight  = 22
    
    var item: FORAlertItem = {
        let alertItem = FORAlertItem()
        alertItem.title = "申请已发出，待反馈"
        alertItem.detail = "Alternative Histories Though Art\n艺术和考古历史"
        alertItem.image = ""
        alertItem.grade = "顾问评分"
        let action = FORAlertAction(title: "分享", style: .highlight, handler: nil)
        alertItem.actions = [action]
        
        return alertItem
    }()
    
    var container = UIView()
    
    var scrollView = UIScrollView()
    
    var contentView = UIView()
    
    var gradeView = UIView()
    
    fileprivate lazy var detailLabel:UILabel = {
        let label = UILabel()
        label.preferredMaxLayoutWidth = FOR_POPUP_WIDTH - 2*FOR_INNER_MARGIN
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(container)
        container.backgroundColor = UIColor.brown
        container.snp.makeConstraints { $0.edges.equalTo(UIEdgeInsetsMake(100, 40, 100, 40)) }
        
        //设置当视图要变小时，视图的压缩改变方式，是水平缩小还是垂直缩小，并设置优先权
        container.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .horizontal)
        //与上边相反是视图的放大改变方式
        container.setContentHuggingPriority(UILayoutPriorityFittingSizeLevel, for: .vertical)
        
        scrollView.backgroundColor = UIColor.cyan
        contentView.backgroundColor = UIColor.lightGray
        //scrollView.addSubview(contentView)
        container.addSubview(scrollView)
        
        var lastAttribute = container.snp.top
        
        if let image = self.item.image {
            let imageView = UIImageView()
            //imageView.sd_setImage(with: URL(string: image))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.backgroundColor = UIColor.blue
            //contentView.addSubview(imageView)
            scrollView.addSubview(imageView)
            imageView.snp.makeConstraints({ (make) in
                make.left.top.equalTo(scrollView)
                make.width.equalToSuperview()
                make.height.equalTo(FOR_IMAGE_HEIGHT)
            })
            lastAttribute = imageView.snp.bottom
        }
        
        if let title = self.item.title, title.characters.count > 0 {
            let titleLabel = UILabel.titleLabelWithText(title)
            //contentView.addSubview(titleLabel)
            scrollView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints({ (make) in
                //make.left.right.equalTo(contentView).inset(UIEdgeInsetsMake(0, FOR_INNER_MARGIN, 0, FOR_INNER_MARGIN))
                make.left.right.equalTo(scrollView).inset(UIEdgeInsetsMake(0, FOR_INNER_MARGIN, 0, FOR_INNER_MARGIN))
                make.height.lessThanOrEqualTo(45)
                make.bottom.equalTo(lastAttribute).offset(-20)
            })
        }
        
        if let detail = self.item.detail, detail.characters.count > 0 {
            //contentView.addSubview(detailLabel)
            scrollView.addSubview(detailLabel)
            configureLabel(detail: detail)
            detailLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(lastAttribute).offset(20)
                //make.left.right.equalTo(contentView).inset(UIEdgeInsetsMake(0, FOR_TEXT_PADDING, 0, FOR_TEXT_PADDING))
                make.left.right.equalTo(scrollView).inset(UIEdgeInsetsMake(0, FOR_TEXT_PADDING, 0, FOR_TEXT_PADDING))
                make.height.equalTo(detailLabelHeight)
            })
            lastAttribute = detailLabel.snp.bottom
        }

        if let grade = self.item.grade {
            
            let gradeView = GradeView()
            scrollView.addSubview(gradeView)
            gradeView.snp.makeConstraints({ (make) in
                make.top.equalTo(lastAttribute).offset(detailLabelHeight+20)
                make.left.equalToSuperview()
                make.width.equalToSuperview()
            })
            lastAttribute = gradeView.snp.bottom
        }
        
        if let actions = self.item.actions, actions.count > 0 {
            
            let buttonContainer = ButtonContainer()
            buttonContainer.actions = actions
            
            container.addSubview(buttonContainer)
            buttonContainer.setupSubviews()
            buttonContainer.snp.makeConstraints({ (make) in
                make.top.equalTo(scrollView.snp.bottom).offset(-CGFloat(actions.count) * FOR_BUTTON_HEIGHT)
                //make.bottom.equalToSuperview()
                make.left.equalToSuperview()
                make.width.equalToSuperview()
            })
            
            
            let emptyView = UIView()
            emptyView.backgroundColor = UIColor.yellow
            scrollView.addSubview(emptyView)
            emptyView.snp.makeConstraints({ (make) in
                make.left.equalToSuperview()
                make.top.equalTo(lastAttribute)
                make.width.equalToSuperview()
                make.height.equalTo(buttonContainer)
            })
            lastAttribute = emptyView.snp.bottom
            
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.center.equalTo(self.container)
            make.bottom.equalTo(lastAttribute)
        }
        
        
        
        
    
        
    }
    
    @objc fileprivate func buttonAction(_ button: UIButton) {
        
    }


    fileprivate func configureLabel(detail: String){
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        let attributeText = NSAttributedString(string: detail,
                                               attributes: [NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.black])
        detailLabel.attributedText = attributeText
        
        let rect = attributeText.boundingRect(with: CGSize(width: FOR_POPUP_WIDTH - 2*FOR_INNER_MARGIN, height: 600),
                                              options: [NSStringDrawingOptions.usesLineFragmentOrigin,NSStringDrawingOptions.usesFontLeading],
                                              context: nil)
        detailLabelHeight = Int(rect.height) + 8
    }

}

class ButtonContainer: UIView {
    
    var actions: [FORAlertAction]?
    
    convenience init(actions: [FORAlertAction]) {
        self.init(frame: CGRect.zero)
        self.actions = actions
        
    }
    
    override init(frame: CGRect) {
        actions = []
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        if let actions = self.actions, actions.count > 0 {
            
            backgroundColor = UIColor.white
          
            var firstButton: UIButton?
            var lastButton: UIButton?
            for index in 0..<actions.count {
                let action = actions[index]
                let button = UIButton(type: .system)
                addSubview(button)
                button.tag = index
                button.setTitle(action.title, for: .normal)
                button.setTitleColor(UIColor.blue, for: .normal)
                
                button.snp.makeConstraints({ (make) in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(FOR_BUTTON_HEIGHT)
                    if nil == firstButton {
                        firstButton = button
                        make.top.equalToSuperview().offset(-FOR_SPLIT_WIDTH)
                    } else {
                        make.top.equalTo(lastButton!.snp.bottom).offset(-FOR_SPLIT_WIDTH)
                    }
                    lastButton = button
                })
            }
            
            snp.makeConstraints({ (make) in
                make.bottom.equalTo(lastButton!.snp.bottom)
            })
        }
    }
    
}

private extension UILabel {
    class func titleLabelWithText(_ text: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = text
        return label
    }
}

