//
//  ViewController.swift
//  CloudKitDemo
//
//  Created by 刘康 on 16/7/28.
//  Copyright © 2016年 刘康. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var diaries: [Diary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func startSync(sender: AnyObject) {
        debugPrint("Fetch...")
        
        fetch()
    }
    
    @IBAction func trash(sender: AnyObject) {
        fetchCloudRecords { [weak self] (records) in
            debugPrint(records?.count)
            self?.diaries = recordsToDiary(records)
            if let records = records {
                for record in records {
                    deleteCloudRecord(record)
                }
                debugPrint("delete completed")
            }
        }
    }
    
    @IBAction func edit(sender: AnyObject) {
        self.tableView.editing = true
    }
    
    func fetch() {
        fetchCloudRecords { [weak self] (records) in
            debugPrint(records?.count)
            self?.diaries = recordsToDiary(records)
            
            dispatch_async(dispatch_get_main_queue(), { 
                self?.tableView.reloadData()
            })
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaries == nil ? 0 : diaries!.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DiaryListCell")
        let diary = diaries![indexPath.row]
        cell?.textLabel?.text = (diary.title ?? "") + "    " + (diary.location ?? "")
        cell?.detailTextLabel?.text = diary.content
        return cell!
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let diary = self.diaries![indexPath.row]
        deleteCloudRecord(diaryToRecord(diary))
        fetch()
    }
}

