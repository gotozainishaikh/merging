//
//  DraftListViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 11/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import SwipeCellKit
import CoreData
import Alamofire
import SVProgressHUD
import SwiftyJSON

class DraftListViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
    let url = FixVariable()
    var model : [FavListModel] = [FavListModel]()
    
    var imageView : UIImageView!
    
    @IBOutlet weak var draftTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        draftTable.allowsSelection = false
        
        draftTable.register(UINib(nibName: "FavCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
        
      
        
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
    
    
    //Mark - Retrieve Data
    func retriveData() {
        SVProgressHUD.show(withStatus: "Loading")
        
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        var id : String = res.value(forKey: "user_id") as! String
        
        print("\(id)")
        
        
        let parameters : [String:String] = [
            
            "p_id": id
            
        ]
        
        Alamofire.request("\(self.url.weburl)/draftList.php", method: .get, parameters: parameters).responseJSON { (response) in
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
                    self.draftTable.reloadData()
                }
                self.model.removeAll()
                
                for item in 0..<dataJSON.count {
                    
                    let para : [String:Int] = [
                        "id" : dataJSON[item]["collaboration_id"].intValue
                    ]
                    Alamofire.request("\(self.url.weburl)/fetchDraftImages.php", method: .get, parameters: para).responseJSON { (response) in
                        
                        if response.result.isSuccess {
                            
                            
                            
                            let dataJSON1 : JSON = JSON(response.result.value!)
                            // let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                            //                            print(dataJSON[item])
                            //                             print(dataJSON1)
                            
                            let statusModel = FavListModel()
                            
                            if dataJSON1[0]["img_url"].stringValue == ""{
                                statusModel.announcementImage = "https://purpledimes.com/OrderA07Collabrub/WebServices/collaboration_images/No-image-found.jpg"
                            }else {
                                statusModel.announcementImage = dataJSON1[0]["img_url"].stringValue
                            }
                            
                            if dataJSON[item]["collaboration_name"].stringValue == "" {
                                statusModel.title = "Draft"
                            }else {
                                statusModel.title = dataJSON[item]["collaboration_name"].stringValue
                                
                            }
                            statusModel.companyName = dataJSON[item]["company_name"].stringValue
                            statusModel.location = dataJSON[item]["address"].stringValue
                            statusModel.productImage = [dataJSON1[0]["img_url"].stringValue,dataJSON1[1]["img_url"].stringValue,dataJSON1[2]["img_url"].stringValue]
                            statusModel.palceImages = ["",""]
                            statusModel.reviews = ["",""]
                            statusModel.date = dataJSON[item]["date"].stringValue
                            if dataJSON[item]["descriptions"].stringValue == "" {
                            statusModel.description = "No Description"
                            }else{
                                statusModel.description = dataJSON[item]["descriptions"].stringValue
                                
                            }
                            statusModel.collaborattionTerms = dataJSON[item]["collaboration_terms"].stringValue
                            statusModel.avalaibility = ""
                            statusModel.selectedNumOfFollowers = dataJSON[item]["followers_limit"].stringValue
                            //                            statusModel.lat = dataJSON[item]["lat"].doubleValue
                            //                            statusModel.long = dataJSON[item]["longg"].doubleValue
                            statusModel.partner_id = dataJSON[item]["partner_id"].stringValue
                            statusModel.collaboration_id = dataJSON[item]["collaboration_id"].stringValue
                            statusModel.status = dataJSON[item]["subscribe_status"].intValue
                            
                            self.model.append(statusModel)
                            
                            print(statusModel.announcementImage)
                            //   SVProgressHUD.dismiss()
                            
                        }else {
                            print("error not get in first")
                        }
                        
                        //    print("count \(self.model.count)")
                        // SVProgressHUD.dismiss()
                        self.draftTable.reloadData()
                        
                    }
                    
                    
                }
                
                //                if dataJSON["Status"] == "failed" {
                //                    self.model.removeAll()
                //                    self.statusTable.re
                //                }
                //
                
                }else {
//                    let alert = UIAlertController(title: "Alert", message: "You have no data in draft", preferredStyle: .alert)
//                    self.present(alert, animated: true, completion: nil)

                    
                    self.view.addSubview(self.imageView)
                    
                }
            }else {
                print("Error in fetching data")
            }
            
        }
    }


}


extension DraftListViewController : UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavCellTableViewCell
        cell.delegate = self
        
        cell.usrImg.sd_setImage(with: URL(string: model[indexPath.row].announcementImage))
        if model[indexPath.row].title == "Draft" {
            cell.advertisementTitle.textColor = UIColor.red
        }else{
            cell.advertisementTitle.textColor = UIColor(named: "ThemeColor1")
        }
        cell.advertisementTitle.text = model[indexPath.row].title
        cell.advertisementDetails.text = model[indexPath.row].description
        cell.dateLabel.isHidden = false
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        if var date = dateFormatter.date(from: model[indexPath.row].date) {
        
        let calender = NSCalendar.current
        let year = calender.component(.year, from: date)
        let month = calender.component(.month, from: date)
        let day = calender.component(.day, from: date)
        
        cell.dateLabel.text = "\(day) \(monthName(month: month))"
        
        }
        
        //Image Round
        cell.usrImg.layer.cornerRadius = cell.usrImg.frame.size.width/2
        cell.usrImg.clipsToBounds = true
        
        
        
        return cell
    }
    
    
    func monthName(month:Int)->String {
        
        var monthNam : String = ""
        if(month == 1) {
            monthNam = "Jan"
            
        } else if(month == 2){
            monthNam = "Feb"
        } else if(month == 3){
            monthNam = "Mar"
        } else if(month == 4){
            monthNam = "Apr"
        } else if(month == 5){
            monthNam = "MAY"
        } else if(month == 6){
            monthNam = "JUNE"
        } else if(month == 7){
            monthNam = "JULY"
        } else if(month == 8){
            monthNam = "Aug"
        } else if(month == 9){
            monthNam = "Sep"
        } else if(month == 10){
            monthNam = "Oct"
        } else if(month == 11){
            monthNam = "Nov"
        } else if(month == 12){
            monthNam = "Dec"
        }
        
        return monthNam
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: nil) { action, indexPath in
            
            //   self.updateData(at: indexPath)
            
            
            let results : NSArray = try! self.context.fetch(self.request) as NSArray
            
            let res = results[0] as! NSManagedObject
            
            var id : String = res.value(forKey: "user_id") as! String
            
            print("\(id)")
            //print(indexPath.row)
            
            print(self.model[indexPath.row].collaboration_id)
            
            if let idd : String = self.model[indexPath.row].collaboration_id {
                
                let parameters : [String:String] = [
                    
                    "p_id": id,
                    "collaboration_id" : idd
                    
                ]
                
                Alamofire.request("\(self.url.weburl)/delete_draft.php", method: .get, parameters: parameters).responseJSON { (response) in
                    
                    SVProgressHUD.show(withStatus: "Deleting")
                    
                    if response.result.isSuccess {
                        
                        let dataJSON : JSON = JSON(response.result.value!)
                        
                        print(dataJSON)
                        // self.model.remove(at: indexPath.row)
                        SVProgressHUD.dismiss()
                    }
                }
                
                self.model.remove(at: indexPath.row)
                self.draftTable.reloadData()
            }
            print("delete")
            
            self.retriveData()
            //  self.model.remove(at: indexPath.row)
        }
        
        let editAction = SwipeAction(style: .default, title: nil) { action, indexPath in
            
            //   self.updateData(at: indexPath)
            
            let results : NSArray = try! self.context.fetch(self.request) as NSArray
            
            let res = results[0] as! NSManagedObject
            
            var id : String = res.value(forKey: "user_id") as! String
            
            print("\(id)")
            
            if let idd : String = self.model[indexPath.row].collaboration_id {
                print("idd\(idd)")
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "stepController") as! StepViewController
                vc.editing_id = idd
                self.present(vc, animated: true, completion: nil)
                
              
            }
            
            print("edit")
            
            
            //  self.model.remove(at: indexPath.row)
        }
        
        
        
        // customize the action appearance
        
        editAction.image = UIImage(named: "pencl")
        deleteAction.image = UIImage(named: "delete-icon")
        editAction.backgroundColor = UIColor.white
        
        return [deleteAction, editAction]
        
        
    }
    
    
    
}
