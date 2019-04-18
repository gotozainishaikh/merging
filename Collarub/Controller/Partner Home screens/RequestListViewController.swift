//
//  RequestListViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 01/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import  SVProgressHUD
import SwiftyJSON
import CoreLocation
import SDWebImage

class RequestListViewController: UIViewController {

    var favArray : FavListModel!
   // var list_id : String!
    
    @IBOutlet weak var blockRequestSwitch: UISwitch!
    @IBOutlet weak var autoApprvSwitch: UISwitch!
    var model : [RequestCellModel] = [RequestCellModel]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
    let url = FixVariable()
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        print(favArray.block)
        if favArray.autoapprv == "1"{
            autoApprvSwitch.isOn = true
        }else if favArray.autoapprv == "0"{
            autoApprvSwitch.isOn = false
        }
        
        if favArray.block == "1"{
            blockRequestSwitch.isOn = true
        }else if favArray.block == "0"{
            blockRequestSwitch.isOn = false
        }
        
        autoApprvSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        blockRequestSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
       NotificationCenter.default.addObserver(self, selector: #selector(loadList(req_notification:)), name: NSNotification.Name(rawValue: "reqAcp"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(rejectList(req_notification:)), name: NSNotification.Name(rawValue: "reqreject"), object: nil)
        
       // list_id = favArray.collaboration_id
        print("this "+(favArray?.collaboration_id)!)
        
        retriveData(id: favArray.collaboration_id)
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "requestCell")
        
        tableView.separatorStyle = .none
        //configureTableView()
        uiNavegationImage()
    }
    
    // MARK - Observer accept Method
    
    @objc func loadList(req_notification: NSNotification) {
        
        var req_id : String = ""
        
        if let dict = req_notification.userInfo as NSDictionary? {
            if let id = dict["req_id"] as? String{
                print("id="+id)
                // print("hosp_id="+hosp_id!)
                req_id = id
            }
            
            let parameters : [String:String] = [
                
                "req_id": req_id,
                "req_condition" : "accept",
                "col_id" : favArray.collaboration_id
            ]
            
            Alamofire.request("\(self.url.weburl)/request_accept_and_reject.php", method: .get, parameters: parameters).responseJSON { (response) in
                SVProgressHUD.show(withStatus: "Loading")
                if response.result.isSuccess {
                    SVProgressHUD.dismiss()
                    self.retriveData(id: self.favArray.collaboration_id)
                }
                
            }
            
            
            
        }
    }
    
    @objc func rejectList(req_notification: NSNotification) {
        
        var req_id : String = ""
        
        if let dict = req_notification.userInfo as NSDictionary? {
            if let id = dict["req_id"] as? String{
                print("id="+id)
                // print("hosp_id="+hosp_id!)
                req_id = id
            }
            
            let parameters : [String:String] = [
                
                "req_id": req_id,
                "req_condition" : "reject"
                
            ]
            
            Alamofire.request("\(self.url.weburl)/request_accept_and_reject.php", method: .get, parameters: parameters).responseJSON { (response) in
                SVProgressHUD.show(withStatus: "Loading")
                if response.result.isSuccess {
                    SVProgressHUD.dismiss()
                    self.retriveData(id: self.favArray.collaboration_id)
                }
                
            }
            
            
            
        }
    }
    
    
    
    
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    
    func configureTableView(){
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150.0
        
    }
    func retriveData(id : String){
        SVProgressHUD.show(withStatus: "Loading")
    let parameters : [String:String] = [
        
        "col_id": id
        
    ]
    
    Alamofire.request("\(self.url.weburl)/request_list.php", method: .get, parameters: parameters).responseJSON { (response) in
            SVProgressHUD.show(withStatus: "Loading")
            if response.result.isSuccess {
    
                SVProgressHUD.dismiss()
    
                let dataJSON : JSON = JSON(response.result.value!)
    
    
    
               // print(dataJSON)
                if dataJSON.count < 1 {
                self.model.removeAll()
                self.tableView.reloadData()
                    }
                self.model.removeAll()
    
                for item in 0..<dataJSON.count {
                    var countryName = ""
                    if dataJSON[item]["user_location"].stringValue != "" {
                    let addressStrin = dataJSON[item]["user_location"].stringValue.components(separatedBy: ",")
                        if addressStrin.count == 2 {
                         countryName = addressStrin[2]
                        }
                    }
                     //print(surname)
                    
                    print(dataJSON[item])
                    
                    let statusModel = RequestCellModel()
                    
                    statusModel.usrImg = dataJSON[item]["image_url"].stringValue
                    statusModel.usrName = dataJSON[item]["full_name"].stringValue
                    statusModel.locaName = countryName
                    statusModel.followrs = dataJSON[item]["followers"].stringValue
                    statusModel.req_id = dataJSON[item]["request_id"].stringValue
                    
                    print("\(statusModel)")
                    self.model.append(statusModel)
                    
                    
                    
                }
                
            }else {
                print("error in fetching")
                
        }
        self.tableView.reloadData()

        }    }
    
    
    @IBAction func autoApprv(_ sender: UISwitch) {
        if autoApprvSwitch.isOn {
            print("Hit Api")
            blockRequestSwitch.isOn = false
          //  autoApprvSwitch.setOn(false, animated:true)
            
            let parameters : [String:String] = [
                
                "collaboration_id": favArray.collaboration_id,
                "auto_approve" : "1",
                "block_status" : "0"
                
            ]
            
            Alamofire.request("\(self.url.weburl)/update_block_status.php", method: .get, parameters: parameters).responseJSON { (response) in
                SVProgressHUD.show(withStatus: "Loading")
                if response.result.isSuccess {
                    SVProgressHUD.dismiss()
                   let dataJSON1 : JSON = JSON(response.result.value!)
                    
                    if dataJSON1["Status"] == "success" {
                        SVProgressHUD.showSuccess(withStatus: "Done")
                    }
                }
                
            }
            
            
        } else {
            let parameters : [String:String] = [
                
                "collaboration_id": favArray.collaboration_id,
                "auto_approve" : "0",
                "block_status" : "0"
                
            ]
            
            Alamofire.request("\(self.url.weburl)/update_block_status.php", method: .get, parameters: parameters).responseJSON { (response) in
                SVProgressHUD.show(withStatus: "Loading")
                if response.result.isSuccess {
                    SVProgressHUD.dismiss()
                    let dataJSON1 : JSON = JSON(response.result.value!)
                    
                    if dataJSON1["Status"] == "success" {

                         
                        SVProgressHUD.showSuccess(withStatus: "Done")
                        
                    }
                }
                
            }
           // autoApprvSwitch.setOn(true, animated:true)
        }
    }
    @IBAction func blockreq(_ sender: UISwitch) {
        if blockRequestSwitch.isOn {
            print("The Switch is On")
            autoApprvSwitch.isOn = false
           
            let parameters : [String:String] = [
                
                "collaboration_id": favArray.collaboration_id,
                "auto_approve" : "0",
                "block_status" : "1"
                
            ]
            
            Alamofire.request("\(self.url.weburl)/update_block_status.php", method: .get, parameters: parameters).responseJSON { (response) in
                SVProgressHUD.show(withStatus: "Loading")
                if response.result.isSuccess {
                    SVProgressHUD.dismiss()
                    let dataJSON1 : JSON = JSON(response.result.value!)
                    
                    if dataJSON1["Status"] == "success" {
                        
                        
                        SVProgressHUD.showSuccess(withStatus: "Done")
                        
                    }
                }
                
            }
        } else {
            print("The Switch is Off")
            let parameters : [String:String] = [
                
                "collaboration_id": favArray.collaboration_id,
                "auto_approve" : "0",
                "block_status" : "0"
                
            ]
            
            Alamofire.request("\(self.url.weburl)/update_block_status.php", method: .get, parameters: parameters).responseJSON { (response) in
                SVProgressHUD.show(withStatus: "Loading")
                if response.result.isSuccess {
                    SVProgressHUD.dismiss()
                    let dataJSON1 : JSON = JSON(response.result.value!)
                    
                    if dataJSON1["Status"] == "success" {
                        
                        
                        SVProgressHUD.showSuccess(withStatus: "Done")
                        
                    }
                }
                
            }
        }
    }
}


extension RequestListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath) as! TableViewCell
        
        
        cell.usrName.text = model[indexPath.row].usrName
        cell.locName.text = model[indexPath.row].locaName
        cell.followrs.text = model[indexPath.row].followrs
        cell.req_id = model[indexPath.row].req_id
        cell.usrImg.sd_setImage(with: URL(string: model[indexPath.row].usrImg))
        //Image Round
        cell.usrImg.layer.cornerRadius = cell.usrImg.frame.size.width/2
        cell.usrImg.clipsToBounds = true
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       // self.performSegue(withIdentifier: "requestList", sender: nil)
        
    }
    
    
    
}
