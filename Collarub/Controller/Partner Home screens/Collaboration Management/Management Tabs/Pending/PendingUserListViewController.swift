//
//  PendingUserListViewController.swift
//  Collarub
//
//  Created by mac on 13/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import CoreData
import SVProgressHUD

class PendingUserListViewController: UIViewController {

    
    var model : [FindInfluencerModel] = [FindInfluencerModel]()
    var usr_id : String = ""
     var imageView : UIImageView!
    let url = FixVariable()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "PendingUserListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
     
        print("use id is \(usr_id)")
    }
    

    override func viewDidAppear(_ animated: Bool) {
        let imageName = "nodataavail.jpeg"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: self.view.frame.size.width  / 2 - 150, y: self.view.frame.size.height / 2 + 50, width: 300, height: 100)
        retriveData()
        imageView.tag = 100
        
    }
  
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        print("hello")
    }
    
    
    
    func retriveData() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
        
        SVProgressHUD.show(withStatus: "Loading")
        
       
        
        let parameters : [String:String] = [
            
            "campaign_id": usr_id
            
            
        ]
        
        Alamofire.request("\(self.url.weburl)/get_assigned_users_via_campaign.php", method: .get, parameters: parameters).responseJSON { (response) in
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
                        self.tableView.reloadData()
                    }
                    self.model.removeAll()
                    
                    
                    for item in 0..<dataJSON.count {
                        
                            
                                let statusModel = FindInfluencerModel()
                                
                        statusModel.productStatus = dataJSON[item]["product_sent"].stringValue
                        statusModel.user_id = dataJSON[item]["user_id"].stringValue
                        statusModel.usrImg = dataJSON[item]["image_url"].stringValue
                        statusModel.usrname = dataJSON[item]["full_name"].stringValue
                        statusModel.userAddress = dataJSON[item]["user_location"].stringValue
                        
                        
                                self.model.append(statusModel)
                                //   SVProgressHUD.dismiss()
                                
                           
                            
                            //    print("count \(self.model.count)")
                            // SVProgressHUD.dismiss()
                            self.tableView.reloadData()
                            
                       
                        
                        
                    }
                    
                    //                if dataJSON["Status"] == "failed" {
                    //                    self.model.removeAll()
                    //                    self.statusTable.re
                    //                }
                    //
                    
                }else {
                    self.view.addSubview(self.imageView)
                    self.model.removeAll()
                    self.tableView.reloadData()
                }
                
            }else {
                print("Error in fetching data")
                self.retriveData()
            }
            
        }
    }

    
    
}


extension PendingUserListViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PendingUserListTableViewCell
        cell.usrName.text = model[indexPath.row].usrname
        cell.usrLocation.text = model[indexPath.row].userAddress
        cell.usrImg.sd_setImage(with: URL(string: model[indexPath.row].usrImg))
        if model[indexPath.row].productStatus == "0" {
            cell.productStatus.text = "Pending"
        }else {
            cell.productStatus.text = "Product Sent"
        }
        //Image Round
                cell.usrImg.layer.cornerRadius = cell.usrImg.frame.size.width/2
                cell.usrImg.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if model[indexPath.row].productStatus == "0" {
        let vc = storyboard?.instantiateViewController(withIdentifier: "pendingClick") as! PendingPopUpViewController
        vc.model = model[indexPath.row]
       // vc.model = model
                self.addChild(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
        }
    }
}
