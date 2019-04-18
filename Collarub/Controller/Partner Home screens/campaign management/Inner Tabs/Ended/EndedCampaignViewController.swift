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
                
                let modl = dict["modal"]
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "paystep5") as! step5endedViewController
                vc.model = modl as! LocalModel
                present(vc, animated: true, completion: nil)
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
            
            "partner_id": id
            
        ]
        
        Alamofire.request("\(self.url.weburl)/completed_collaboration.php", method: .get, parameters: parameters).responseJSON { (response) in
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
                                localModel.partner_id = id
                                localModel.productImage = [dataJSON1[0]["img_url"].stringValue,dataJSON1[1]["img_url"].stringValue,dataJSON1[2]["img_url"].stringValue,dataJSON1[3]["img_url"].stringValue,dataJSON1[4]["img_url"].stringValue,dataJSON1[5]["img_url"].stringValue]
                                localModel.palceImages = ["",""]
                                localModel.reviews = ["",""]
                                localModel.date = dataJSON[item]["date"].stringValue
                                localModel.description = dataJSON[item]["descriptions"].stringValue
                                localModel.collaborattionTerms = dataJSON[item]["collaboration_terms"].stringValue
                                localModel.avalaibility = ""
                                localModel.selectedNumOfFollowers = dataJSON[item]["followers_limit"].stringValue
                                localModel.lat = dataJSON[item]["lat"].doubleValue
                                localModel.long = dataJSON[item]["longg"].doubleValue
                                localModel.collaboration_id = dataJSON[item]["collaboration_id"].stringValue
                                localModel.collaborationType = dataJSON[item]["collaborationType"].stringValue
                                localModel.category_name = dataJSON[item]["category_name"].stringValue
                                
                                
                                localModel.expiry_date = dataJSON[item]["expiry_date"].stringValue
                                localModel.Accep_budget_check = dataJSON[item]["accep_budget_check"].stringValue
                                
                                localModel.number_post = dataJSON[item]["number_post"].stringValue
                                localModel.number_stories = dataJSON[item]["number_stories"].stringValue
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
                                localModel.rating = dataJSON[item]["min_user_rating"].stringValue
                                localModel.what_u_offer = dataJSON[item]["what_u_offer"].stringValue
                                localModel.wht_thy_hav_to_do = dataJSON[item]["wht_thy_hav_to_do"].stringValue
                                localModel.wht_wont_hav_to = dataJSON[item]["wht_wont_hav_to"].stringValue
                                localModel.e_mail = dataJSON[item]["e_mail"].stringValue
                                localModel.phone = dataJSON[item]["phone"].stringValue

                                localModel.payment_method = dataJSON[item]["payment_method"].stringValue

                                localModel.payment_conditions = dataJSON[item]["payment_conditions"].stringValue

                                localModel.auto_approve = dataJSON[item]["auto_approve"].stringValue
                                localModel.coupon_status = dataJSON[item]["coupon_status"].stringValue
                                localModel.collab_limit = dataJSON[item]["total_num_influencer"].stringValue
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
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! endedTableViewCell
        cell.imgUsr.sd_setImage(with: URL(string: model[indexPath.row].announcementImage))
        cell.title.text = model[indexPath.row].title
        cell.decrip.text = model[indexPath.row].description
        cell.budgt.text = model[indexPath.row].budget_value
        cell.req_id = String(model[indexPath.row].collaboration_id)
        cell.model = model[indexPath.row]
        //Image Round
        cell.imgUsr.layer.cornerRadius = cell.imgUsr.frame.size.width/2
        cell.imgUsr.clipsToBounds = true
        return cell
    }
    
    
    
    
    
    
    
}
