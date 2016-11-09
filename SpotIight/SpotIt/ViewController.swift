//
//  ViewController.swift
//  SpotIt
//
//  Created by 刘康 on 16/9/8.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

import UIKit

import CoreSpotlight
import MobileCoreServices

class ViewController: UIViewController {
    
    @IBOutlet weak var tblMovies: UITableView!
    
    var moviesInfo: NSMutableArray!
    
    var selectedMovieIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 从文件里加载电影数据
        loadMoviesInfo()
        
        configureTableView()
        navigationItem.title = "Movies"
        
        setupSearchableContent()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier where identifier == "idSegueShowMovieDetails" {
            let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
            movieDetailsViewController.movieInfo = moviesInfo[selectedMovieIndex] as! [String : String]
        }
    }
    
    override func restoreUserActivityState(activity: NSUserActivity) {
        if activity.activityType == CSSearchableItemActionType {
            if let userInfo = activity.userInfo {
                let selectedMovie = userInfo[CSSearchableItemActivityIdentifier] as! String
                selectedMovieIndex = Int(selectedMovie.componentsSeparatedByString(".").last!)
                performSegueWithIdentifier("idSegueShowMovieDetails", sender: self)
            }
        }
    }
    
}

extension ViewController {
    
    // MARK: Custom Functions
    
    func configureTableView() {
        tblMovies.delegate = self
        tblMovies.dataSource = self
        tblMovies.tableFooterView = UIView(frame: CGRectZero)
        tblMovies.registerNib(UINib(nibName: "MovieSummaryCell", bundle: nil), forCellReuseIdentifier: "idCellMovieSummary")
    }
    
    func loadMoviesInfo() {
        if let path = NSBundle.mainBundle().pathForResource("MoviesData", ofType: "plist") {
            moviesInfo = NSMutableArray(contentsOfFile: path)
        }
    }
    
}


extension ViewController {
    // MARK: 为 Spotlight 索引数据
    func setupSearchableContent() {
        var searchableItems = [CSSearchableItem]()
        for i in 0...(moviesInfo.count - 1) {
            let movie = moviesInfo[i] as! [String: String]
            
            let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            
            // 设置标题.
            searchableItemAttributeSet.title = movie["Title"]!
            
            // 设置电影封面.
            let imagePathParts = movie["Image"]!.componentsSeparatedByString(".")
            searchableItemAttributeSet.thumbnailURL = NSBundle.mainBundle().URLForResource(imagePathParts[0], withExtension: imagePathParts[1])
            
            // 设置简介.
            searchableItemAttributeSet.contentDescription = movie["Description"]!
            
            // 设置关键词
            var keywords = [String]()
            let movieCategories = movie["Category"]!.componentsSeparatedByString(", ")
            for movieCategory in movieCategories {
                keywords.append(movieCategory)
            }
            
            let stars = movie["Stars"]!.componentsSeparatedByString(", ")
            for star in stars {
                keywords.append(star)
            }
            
            searchableItemAttributeSet.keywords = keywords
            
            // 构建可搜索项目病添加到数组
            let searchableItem = CSSearchableItem(uniqueIdentifier: "com.appcoda.SpotIt.\(i)", domainIdentifier: "movies", attributeSet: searchableItemAttributeSet)
            searchableItems.append(searchableItem)
            
        }
        // 使用 Core Spotlight API 索引这些项目
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems(searchableItems) { (error) -> Void in
            if error != nil {
                print(error?.localizedDescription)
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK:  UITableView Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesInfo != nil {
            return moviesInfo.count
        }
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idCellMovieSummary", forIndexPath: indexPath) as! MovieSummaryCell
        
        let currentMovieInfo = moviesInfo[indexPath.row] as! [String: String]
        
        cell.lblTitle.text = currentMovieInfo["Title"]!
        cell.lblDescription.text = currentMovieInfo["Description"]!
        cell.lblRating.text = currentMovieInfo["Rating"]!
        cell.imgMovieImage.image = UIImage(named: currentMovieInfo["Image"]!)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedMovieIndex = indexPath.row
        performSegueWithIdentifier("idSegueShowMovieDetails", sender: self)
    }
}
