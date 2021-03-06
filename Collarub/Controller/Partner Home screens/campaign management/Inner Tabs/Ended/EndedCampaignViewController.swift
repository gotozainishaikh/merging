//
//  EndedCampaignViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 11/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import SDWebImage
import CoreData
import SVProgressHUD

class EndedCampaignViewController: UIViewController {

    @IBOutlet weak var endedTable: UITableView!
    
    var model : [LocalModel] = [LocalModel]()
    let url = FixVariable()
    var imageView : UIImageView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(rejectList(req_notification:)), name: NSNotification.Name(rawValue: "reqreject"), object: nil)
        
        endedTable.register(UINib(nibName: "endedTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
       // retriveData()
        endedTable.allowsSelection = false
        
//        endedTable.rowHeight = UITableView.automaticDimension
//        endedTable.estimatedRowHeight = 200
        
    }
    
    @objc func rejectList(req_notification: NSNotification) {
        
        var req_id : String = ""
        
        if let dict = req_notification.userInfo as NSDictionary? {
            if let id = dict["req_id"] as? String{
                print("id="+id)
                // print("hosp_id="+hosp_id!)
                req_id = id
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "paystep5")
                present(vc!, animated: true, completion: nil)
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retriveData()
        
        let imageName = "nodataavail.jpeg"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: self.view.frame.size.width  / 2 - 150, y: self.view.frame.size.height / 2 - 50, width: 300, height: 100)
        
        imageView.tag = 100
    }
    
    func retriveData() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
        
        SVProgressHUD.show(withStatus: "Loading")
        
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        var id : String = res.value(forKey: "user_id") as! String
        
        print("\(id)")
        
        
        let parameters : [String:String] = [
            
            "p_id": id
            
        ]
        
        Alamofire.request("\(self.url.weburl)/endedList.php", method: .get, parameters: parameters).responseJSON { (response) in
            SVProgressHUD.show(withStatus: "Connecting to server")
            if response.result.isSuccess {
                
                SVProgressHUD.dismiss()
                
                let dataJSON : JSON = JSON(response.result.value!)
                if dataJSON["Status"] != "failed" {
                    if let viewWithTag = self.view.viewWithTag(100) {
                        viewWithTag.removeFromSuperview()
                    }
                    
                    print(dataJSON)
                    if dataJSON.count < 1 {
                        self.model.removeAll()
                        self.endedTable.reloadData()
                    }
                    self.model.removeAll()
                    
                    for item in 0..<dataJSON.count {
                        
                        let para : [String:Int] = [
                            "id" : dataJSON[item]["collaboration_id"].intValue
                        ]
                        Alamofire.request("\(self.url.weburl)/collabrubImages.php", method: .get, parameters: para).responseJSON { (response) in
                            
                            if response.result.isSuccess {
                                
                                let dataJSON1 : JSON = JSON(response.result.value!)
                                // let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                                //                            print(dataJSON[item])
                                //                             print(dataJSON1)
                                
                                let localModel = LocalModel()
                                
                                
                                localModel.announcementImage = dataJSON1[0]["img_url"].stringValue
                                localModel.title = dataJSON[item]["collaboration_name"].stringValue
                                localModel.companyName = dataJSON[item]["company_name"].stringValue
                                localModel.location = dataJSON[item]["address"].stringValue
                                localModel.productImage = [dataJSON1[0]["img_url"].stringValue,dataJSON1[1]["img_url"].stringValue,dataJSON1[2]["img_url"].stringValue,dataJSON1[3]["img_url"].stringValue,dataJSON1[4]["img_url"].stringValue,dataJSON1[5]["img_url"].stringValue]
                                localModel.palceImages = ["",""]
                                localModel.reviews = ["",""]
                                localModel.date = dataJSON[item]["date"].stringValue
                                localModel.description = dataJSON[item]["descriptions"].stringValue
                                localModel.collaborattionTerms = dataJSON[item]["collaboration_terms"].stringValue
                                localModel.avalaibility = ""
                                localModel.selectedNumOfFollowers = dataJSON[item]["followers_limit"].stringValue
                                
                                localModel.collaboration_id = dataJSON[item]["collaboration_id"].intValue
                                
                                localModel.expiry_date = dataJSON[item]["expiry_date"].stringValue
                                localModel.Accep_budget_check = dataJSON[item]["Accep_budget_check"].stringValue
                                localModel.budget_value = dataJSON[item]["budget_value"].stringValue
                                localModel.type = dataJSON[item]["type"].stringValue
                                localModel.discount_field = dataJSON[item]["discount_field"].stringValue
                                localModel.content_type = dataJSON[item]["content_type"].stringValue
                                localModel.required_city = dataJSON[item]["required_city"].stringValue
                                localModel.required_region = dataJSON[item]["required_region"].stringValue
                                localModel.engagement_rate = dataJSON[item]["engagement_rate"].stringValue
                                localModel.rating = dataJSON[item]["rating"].stringValue
                                localModel.user_gender = dataJSON[item]["user_gender"].stringValue
                                localModel.min_user_exp_level = dataJSON[item]["min_user_exp_level"].stringValue
                                
                                self.model.append(localModel)
                                //   SVProgressHUD.dismiss()
                                
                            }else {
                                print("error not get in first")
                            }
                            
                            //    print("count \(self.model.count)")
                            // SVProgressHUD.dismiss()
                            self.endedTable.reloadData()
                            
                        }
                        
                        
                    }
                    
                    //                if dataJSON["Status"] == "failed" {
                    //                    self.model.removeAll()
                    //                    self.statusTable.re
                    //                }
                    //
                    
                }else {
                    self.view.addSubview(self.imageView)
                    self.model.removeAll()
                    self.endedTable.reloadData()
                }
                
            }else {
                print("Error in fetching data")
                self.retriveData()
            }
            
        }
    }

}



extension EndedCampaignViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! endedTableViewCell
        cell.imgUsr.sd_setImage(with: URL(string: model[indexPath.row].announcementImage))
        cell.title.text = model[indexPath.row].title
        cell.decrip.text = model[indexPath.row].description
        cell.budgt.text = model[indexPath.row].budget_value
        cell.req_id = String(model[indexPath.row].collaboration_id)
        //Image Round
        cell.imgUsr.layer.cornerRadius = cell.imgUsr.frame.size.width/2
        cell.imgUsr.clipsToBounds = true
        return cell
    }
    
    
    
    
    
    
    
}
