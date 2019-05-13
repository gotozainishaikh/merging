//
//  DetailReviewViewController.swift
//  Collarub
//
//  Created by mac on 13/05/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

import UIKit
import SDWebImage
import CoreData
import Alamofire
import SwiftyJSON


class DetailReviewViewController: UIViewController {

    @IBOutlet weak var reviewTable: UITableView!
    var imageView : UIImageView!
    let story = UIStoryboard(name: "Main", bundle: nil)
    var model : [ReviewModel] = [ReviewModel]()
    // var id : String = ""
    let url = FixVariable()
    var refresher:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reviewTable.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewCell")
//        retriveData()
        reviewTable.allowsSelection = false
        reviewTable.separatorStyle = .none
        
        uiNavegationImage()
        print("data :: \(model)")
//        self.refresher = UIRefreshControl()
//        self.reviewTable!.alwaysBounceVertical = true
//        self.refresher.tintColor = UIColor.gray
//        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
//        self.reviewTable!.addSubview(refresher)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    
    
    @objc func loadData() {
        //code to execute during refresher
        
       // retriveData()
        stopRefresher()         //Call this to stop refresher
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    

  

}



extension DetailReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("modelfav.count=\(model.count)")
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
        
        cell.reviewerImg.sd_setImage(with: URL(string: model[indexPath.row].reviewerImg) )
        cell.reviewerName.text = model[indexPath.row].reviewerName
        cell.ratingLabel.text = "\(Int(model[indexPath.row].reviewRate)) - 5"
        cell.ratings(ratingValue: model[indexPath.row].reviewRate)
        cell.review.text = model[indexPath.row].review
        
        //Image Round
        cell.reviewerImg.layer.cornerRadius = cell.reviewerImg.frame.size.width/2
        cell.reviewerImg.clipsToBounds = true
        
        
        
        
        return cell
    }
    
    
    
}
