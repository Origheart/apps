//
//  AddEventViewController.swift
//
//  Created by 刘康 on 2016/12/15.
//  Copyright © 2016年 hangge.com. All rights reserved.
//

import UIKit
import EventKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var remarkTextField: UITextField!
    var start, end: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var datePicker = UIDatePicker()
        datePicker.tag = 0
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        startTimeTextField.inputView = datePicker
        
        datePicker = UIDatePicker()
        datePicker.tag = 1
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        endTimeTextField.inputView = datePicker
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
    
        if sender.tag == 0 {
            startTimeTextField.text = formatter.string(from: sender.date)
            start = sender.date
        } else {
            endTimeTextField.text = formatter.string(from: sender.date)
            end = sender.date
        }
    }
    
    @IBAction func save(_ sender: UIButton) {
        if let title = titleTextField.text, let startTime = start, let endTime = end {
            let eventStore = EKEventStore()
            let event:EKEvent = EKEvent(eventStore: eventStore)
            event.title = title
            event.startDate = startTime
            event.endDate = endTime
            event.notes = remarkTextField.text
            event.calendar = eventStore.defaultCalendarForNewEvents
            
            do{
                try eventStore.save(event, span: .thisEvent)
                print("保存日历成功")
            } catch {
                print("保存日历出错")
            }
        }
    }

}

