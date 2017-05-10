//
//  AnimateTextView.swift
//  AnimateTextView
//
//  Created by Origheart on 2017/5/4.
//  Copyright © 2017年 origheart. All rights reserved.
//

import UIKit

class AnimateTextView: UITableView {
    
    var textList: [String] = [] {
        didSet {
            reloadData()
        }
    }
    
    var timer: Timer?
    private var animating: Bool = false
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        backgroundColor = UIColor.clear
        clipsToBounds = true
        separatorStyle = .none
        delegate = self
        dataSource = self
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height / 2 - 22))
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height / 2 - 22))
        isUserInteractionEnabled = false
    }
    
    func animate(duration: TimeInterval = 5.0) {
        if animating {
            return
        }
        animating = true
        reloadData()
        scrollTop()
        let totalScrollHeight = contentSize.height - bounds.height
        let stepHeight: CGFloat = 0.5
        let totalScrollCount: CGFloat = CGFloat(totalScrollHeight) / stepHeight
        let stepDuration: CGFloat = CGFloat(duration) / totalScrollCount
        
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(stepDuration), target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(stopScroll), userInfo: nil, repeats: false)
    }
    
    func autoScroll() {
        self.contentOffset = CGPoint(x: 0, y: self.contentOffset.y + 0.5)
    }
    
    func stopScroll() {
        self.timer?.invalidate()
        self.timer = nil
        animating = false
        textList = ["筛选完成"]
    }
    
    func scrollTop() {
        self.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
}

extension AnimateTextView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "AnimateTextCell"
        var cell: UITableViewCell!
        if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            cell = dequeueCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell.textLabel?.text = textList[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.textAlignment = .center
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        // 判断当前cell距离中心点
        let cellRect = tableView.rectForRow(at: indexPath)
        let upY = contentOffset.y - cellRect.origin.y + bounds.height / 2
        if upY < 44 {
            let delta = 1 - abs(upY - 22) / 22
            let fontSize = 15 + 10 * delta
            cell.textLabel?.font = UIFont.systemFont(ofSize: fontSize < 15 ? 15 : fontSize)
            let alpha = 0.5 + 0.5 * delta
            cell.textLabel?.alpha = alpha < 0.5 ? 0.5 : alpha
        } else {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.textLabel?.alpha = 0.5
        }
        
        return cell
    }
}

extension AnimateTextView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        reloadData()
    }
}
