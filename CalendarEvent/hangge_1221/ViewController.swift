//
//  AddEventViewController.swift
//
//  Created by 刘康 on 2016/12/15.
//  Copyright © 2016年 hangge.com. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {
    
    let eventStore = EKEventStore()
    
    var tableView:UITableView?
    
    //日期格式器
    var dformatter:DateFormatter!
    
    //搜索控制器
    var searchController = UISearchController(searchResultsController: nil)
    
    //事件集合
    var events:[EKEvent] = []
    
    //搜索过滤后的结果集
    var filteredEvents:[EKEvent] = []
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化日期格式器
        dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        
        //请求日历
        requestCalendars()
        
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UINib(nibName:"MyTableViewCell", bundle:nil),
                                    forCellReuseIdentifier:"myCell")
        self.view.addSubview(self.tableView!)
        
        //配置搜索控制器
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        //搜索状态下隐藏顶部导航栏
        searchController.hidesNavigationBarDuringPresentation = true
        
        tableView!.tableHeaderView = searchController.searchBar
    }
    
    //请求日历
    func requestCalendars() {
        // 请求日历事件
        eventStore.requestAccess(to: .event, completion: {
            granted, error in
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error  \(error)")
                
                //获取本地日历（剔除节假日，生日等其他系统日历）
                let calendars = self.eventStore.calendars(for: .event).filter({
                    (calender) -> Bool in
                    return calender.type == .local || calender.type == .calDAV
                })
                
                self.events = []
                //获取当前年
                let com = Calendar.current.dateComponents([.year], from: Date())
                let currentYear = com.year!
                print(currentYear)
                
                // 获取所有的事件（前后20年）
                for i in -20...20 {
                    let startDate = self.startOfMonth(year:currentYear+i, month:1)
                    let endDate = self.endOfMonth(year:currentYear+i, month:12,
                                                  returnEndTime:true)
                    print("查询范围 开始:\(startDate) 结束:\(endDate)")
                    
                    let predicate2 = self.eventStore.predicateForEvents(
                        withStart: startDate, end: endDate, calendars: calendars)
                    
                    if let eV = self.eventStore.events(matching: predicate2) as [EKEvent]!
                    {
                        //将获取到的日历事件添加到集合中
                        self.events.append(contentsOf: eV)
                    }
                }
                
                print("事件加载完毕!共\(self.events.count)条数据。")
                //重新刷新表格数据
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
               
            }
        })
    }
    
    //指定年月的开始日期
    func startOfMonth(year: Int, month: Int) -> Date {
        let calendar = Calendar.current
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        let startDate = calendar.date(from: startComps)!
        return startDate
    }
    
    //指定年月的结束日期
    func endOfMonth(year: Int, month: Int, returnEndTime:Bool = false) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        let tem = startOfMonth(year: year, month:month)
        let endOfYear =  calendar.date(byAdding: components, to: tem)!
        return endOfYear
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    //在本例中，只有一个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.searchController.isActive) {
            return self.filteredEvents.count
        } else {
            return self.events.count
        }
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell:MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell")
            as! MyTableViewCell
        var event:EKEvent!
        if self.searchController.isActive {
            event = self.filteredEvents[indexPath.row]
        }else{
            event = self.events[indexPath.row]
        }
        cell.titleLabel.text = event.title
        cell.dateLabel.text = dformatter.string(from: event.startDate)
        cell.sideSign.backgroundColor = UIColor(cgColor:event.calendar.cgColor)
        return cell
    }
}

extension ViewController: UISearchResultsUpdating{
    //搜索栏文字改变后事件
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        filteredEvents = events.filter({( event : EKEvent) -> Bool in
            return  event.title.lowercased().contains(searchText.lowercased())
        })
        tableView?.reloadData()
    }
}

