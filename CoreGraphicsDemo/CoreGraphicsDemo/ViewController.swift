//
//  ViewController.swift
//  CoreGraphicsDemo
//
//  Created by Origheart on 2017/3/2.
//  Copyright © 2017年 origheart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isGraphViewShowing = false

    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        counterLabel.text = String(counterView.counter)
    }

    @IBAction func btnPushButton(_ sender: PushButtonView) {
        if sender.isAddButton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
        if isGraphViewShowing {
            counterViewTap(gesture: nil)
        }
    }
    
    @IBAction func counterViewTap(gesture: UITapGestureRecognizer?) {
        if isGraphViewShowing {
            // hide graph
            UIView.transition(from: graphView,
                              to: counterView,
                              duration: 1.0,
                              options: [UIViewAnimationOptions.showHideTransitionViews, UIViewAnimationOptions.transitionFlipFromLeft],
                              completion: nil)
        } else {
            // show graph
            UIView.transition(from: counterView,
                              to: graphView,
                              duration: 1.0,
                              options: [UIViewAnimationOptions.showHideTransitionViews, UIViewAnimationOptions.transitionFlipFromRight],
                              completion: nil)
            setupGraphDisplay()
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    
    func setupGraphDisplay() {
        let noOfDays: Int = 7
        
        // 1 - replace last day with today's actual data
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        
        // 2 - indicate that the graph needs to be redrawn
        graphView.setNeedsDisplay()
        
        maxLabel.text = "\(graphView.graphPoints.max())"
        
        // 3 - calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        
        // 4 - get today's day number
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        let componentOptions:NSCalendar.Unit = .weekday
        let unitFlag = Set<Calendar.Component>([.weekday])
        let components = calendar.dateComponents(unitFlag, from: Date())
        var weekday = components.weekday
        
        let days = ["S", "S", "M", "T", "W", "T", "F"]
        
        // 5 - set up the day name labels with correct day
        for i in (1..<days.count).reversed() {
            if let labelView = graphView.viewWithTag(i) as? UILabel {
                if weekday! == 7 {
                    weekday = 0
                }
                labelView.text = days[weekday! - 1]
                if weekday! < 0 {
                    weekday = days.count - 1
                }
            }
        }
        
    }

}

