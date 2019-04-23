//
//  PartnerReviewViewController.swift
//  Collarub
//
//  Created by mac on 17/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData
import Alamofire
import SwiftyJSON

class PartnerReviewViewController: UIViewController {

    let story = UIStoryboard(name: "Main", bundle: nil)
    var model : [ReviewModel] = [ReviewModel]()
    let url = FixVariable()
    var refresher:UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewCell")
        
        retriveData()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
    }
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    func retriveData(){
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
        
        
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        var id : String = res.value(forKey: "user_id") as! String
        
        print("\(id)")
        
        
        let parameters : [String:String] = [
            "partner_id": id
            
        ]
        
        Alamofire.request("\(self.url.weburl)/user_reviews_by_partner.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let dataJSON : JSON = JSON(response.result.value!)
                
                //   print(dataJSON)
                self.model.removeAll()
                
                for item in 0..<dataJSON.count {
                    
                    let reviewModel = ReviewModel()
                    
                    reviewModel.reviewerImg = dataJSON[item]["partner_img"].stringValue
                    reviewModel.reviewerName = dataJSON[item]["partner_name"].stringValue
                    reviewModel.reviewRate = dataJSON[item]["ratings"].doubleValue
                    reviewModel.review = dataJSON[item]["review_description"].stringValue
                    
                    self.model.append(reviewModel)
                    
                    self.tableView.reloadData()
                }
                
                
            }else {
                print("Error in fetching data")
            }
            
        }
        
        
    }

}



extension PartnerReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
        
        cell.reviewerImg.sd_setImage(with: URL(string: model[indexPath.row].reviewerImg) )
        cell.reviewerName.text = model[indexPath.row].reviewerName
        cell.ratingLabel.text = "\(model[indexPath.row].reviewRate) - 5"
        cell.ratings(ratingValue: model[indexPath.row].reviewRate)
        
        //Image Round
        cell.reviewerImg.layer.cornerRadius = cell.reviewerImg.frame.size.width/2
        cell.reviewerImg.clipsToBounds = true
        
        
        
        
        return cell
    }
    
    
    
}


