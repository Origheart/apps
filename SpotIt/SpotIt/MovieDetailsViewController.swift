//
//  MovieDetailsViewController.swift
//  SpotIt
//
//  Created by 刘康 on 16/9/8.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var imgMovieImage: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblDirector: UILabel!
    
    @IBOutlet weak var lblStars: UILabel!
    
    @IBOutlet weak var lblRating: UILabel!
    
    var movieInfo: [String: String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lblRating.layer.cornerRadius = lblRating.frame.size.width/2
        lblRating.layer.masksToBounds = true
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        populateMovieInfo()
    }
    
}

extension MovieDetailsViewController {
    func populateMovieInfo() {
        lblTitle.text = movieInfo["Title"]!
        lblCategory.text = movieInfo["Category"]!
        lblDescription.text = movieInfo["Description"]!
        lblDirector.text = movieInfo["Director"]!
        lblStars.text = movieInfo["Stars"]!
        lblRating.text = movieInfo["Rating"]!
        imgMovieImage.image = UIImage(named: movieInfo["Image"]!)
    }
}