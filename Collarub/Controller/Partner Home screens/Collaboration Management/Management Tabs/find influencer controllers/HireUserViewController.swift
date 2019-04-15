//
//  HireUserViewController.swift
//  Collarub
//
//  Created by mac on 11/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SVProgressHUD
import SwiftyJSON

class HireUserViewController: UIViewController {

    var imageView : UIImageView!
    var model : [FavListModel] = [FavListModel]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
    let url = FixVariable()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageName = "nodataavail.jpeg"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: self.view.frame.size.width  / 2 - 150, y: self.view.frame.size.height / 2 - 50, width: 300, height: 100)
        
        imageView.tag = 100
        
        tableView.register(UINib(nibName: "FavCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
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
        
        Alamofire.request("\(self.url.weburl)/fetch_partner_list.php", method: .get, parameters: parameters).responseJSON { (response) in
            SVProgressHUD.show(withStatus: "Connecting to server")
            if response.result.isSuccess {
                
                SVProgressHUD.dismiss()
                
                let dataJSON : JSON = JSON(response.result.value!)
                if dataJSON["Status"] != "failed" {
                    if let viewWithTag = self.view.viewWithTag(100) {
                        viewWithTag.removeFromSuperview()
                    }
                    
                    //                    let calender = NSCalendar.current
                    //                    //      let components = calender.component([.day, .month, .year], from: date)
                    //                    //calender.component([.day, .month, .year], from: T##Date
                    //  )
                    //                    let year = calender.component(.year, from: date)
                    //                    let month = calender.component(.month, from: date)
                    //                    let day = calender.component(.day, from: date)
                    //
                    //
                    //                    print(year)
                    //                    print(month)
                    //                    print(day)
                    
                    print(dataJSON)
                    if dataJSON.count < 1 {
                        self.model.removeAll()
                        self.tableView.reloadData()
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
                                
                                let statusModel = FavListModel()
                                
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
                                
                                self.model.append(statusModel)
                                //   SVProgressHUD.dismiss()
                                
                            }else {
                                print("error not get in first")
                            }
                            
                            //    print("count \(self.model.count)")
                            // SVProgressHUD.dismiss()
                            self.tableView.reloadData()
                            
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
                    self.tableView.reloadData()
                }
                
            }else {
                print("Error in fetching data")
                self.retriveData()
            }
            
        }
    }
    

}


extension HireUserViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavCellTableViewCell
        
        cell.usrImg.sd_setImage(with: URL(string: model[indexPath.row].announcementImage))
        cell.advertisementTitle.text = model[indexPath.row].title
        cell.advertisementDetails.text = model[indexPath.row].description
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("hello")
//        self.performSegue(withIdentifier: "requestList", sender: model[(indexPath.row)])
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "requestList" {
//            let destinationVC = segue.destination as! RequestListViewController
//            destinationVC.favArray = (sender as? FavListModel!)
//
//        }
//    }
    
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
    
    
}
