//
//  CurrentListViewController.swift
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

class CurrentListViewController: UIViewController {

    var model : [Current_list_model] = [Current_list_model]()
    var imageView : UIImageView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
    let url = FixVariable()
    
    @IBOutlet weak var currentListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        currentListTable.register(UINib(nibName: "CurrentListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retriveData()
        
        let imageName = "nodataavail.jpeg"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: self.view.frame.size.width  / 2 - 150, y: self.view.frame.size.height / 2 - 50, width: 300, height: 100)
        
        imageView.tag = 100
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
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
        
        Alamofire.request("\(self.url.weburl)/current_list.php", method: .get, parameters: parameters).responseJSON { (response) in
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
                        self.currentListTable.reloadData()
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
                                
                                let statusModel = Current_list_model()
                                
                                statusModel.announcementImage = dataJSON1[0]["img_url"].stringValue
                                statusModel.title = dataJSON[item]["collaboration_name"].stringValue
                                statusModel.companyName = dataJSON[item]["company_name"].stringValue
                                statusModel.location = dataJSON[item]["address"].stringValue
                                statusModel.productImage = [dataJSON1[0]["img_url"].stringValue,dataJSON1[1]["img_url"].stringValue,dataJSON1[2]["img_url"].stringValue]
                                statusModel.palceImages = ["",""]
                                statusModel.reviews = ["",""]
                                statusModel.date = dataJSON[item]["date"].stringValue
                                statusModel.description = dataJSON[item]["descriptions"].stringValue
                                statusModel.collaborattionTerms = dataJSON[item]["collaboration_terms"].stringValue
                                statusModel.avalaibility = ""
                                statusModel.selectedNumOfFollowers = dataJSON[item]["followers_limit"].stringValue
                                //                            statusModel.lat = dataJSON[item]["lat"].doubleValue
                                //                            statusModel.long = dataJSON[item]["longg"].doubleValue
                                statusModel.partner_id = dataJSON[item]["partner_id"].stringValue
                                statusModel.collaboration_id = dataJSON[item]["collaboration_id"].stringValue
                                statusModel.status = dataJSON[item]["subscribe_status"].intValue
                                statusModel.budgt = dataJSON[item]["budget_value"].stringValue
                                
                                self.model.append(statusModel)
                                //   SVProgressHUD.dismiss()
                                
                            }else {
                                print("error not get in first")
                            }
                            
                            //    print("count \(self.model.count)")
                            // SVProgressHUD.dismiss()
                            self.currentListTable.reloadData()
                            
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
                    self.currentListTable.reloadData()
                }
                
            }else {
                print("Error in fetching data")
                self.retriveData()
            }
            
        }
    }
    
}

extension CurrentListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrentListTableViewCell
        
        cell.imgUsr.sd_setImage(with: URL(string: model[indexPath.row].announcementImage))
        cell.title.text = model[indexPath.row].title
        cell.decrip.text = model[indexPath.row].description
        cell.budgt.text = model[indexPath.row].budgt
        
        //Image Round
        cell.imgUsr.layer.cornerRadius = cell.imgUsr.frame.size.width/2
        cell.imgUsr.clipsToBounds = true
        
        return cell
    }
    

    
    
}
