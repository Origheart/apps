//
//  ViewController.swift
//  FORPageControl
//
//  Created by Origheart on 2016/10/9.
//  Copyright © 2016年 origheart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: FORPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        let contentSize = CGSize(width: scrollView.bounds.width * 3,
                                 height: scrollView.bounds.height)
        scrollView.contentSize = contentSize
        
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        let progressInPage = scrollView.contentOffset.x - (page * scrollView.bounds.width)
        let progress = CGFloat(page) + progressInPage
        pageControl.progress = progress
    }
}
