//
//  PendingProductsViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 02/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import CoreData
import SVProgressHUD
import KDCalendar

class PendingProductsViewController: UIViewController {

    @IBOutlet weak var calenderView: CalendarView!
    var model : [LocalModel] = [LocalModel]()
    @IBOutlet weak var tableView: UITableView!
    var datarry : [String] = [String]()
    
     var imageView : UIImageView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
    let url = FixVariable()
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCalendar()
        tableView.register(UINib(nibName: "PendingListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        //tableView.reloadData()
     //   uiNavegationImage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(req_notification:)), name: NSNotification.Name(rawValue: "setcalandar"), object: nil)
        
    }
    
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }

    @objc func loadList(req_notification: NSNotification) {
        let today = Date()
        self.calenderView.setDisplayDate(today)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retriveData() {
            print("mss :: \(self.datarry)")
            
        }
        tableView.allowsSelection = false
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        var dat = dateFormatter.string(from: date as Date)
        print("mydate \(dat)")
        //retriveData(date: dat)
        let imageName = "nodataavail.jpeg"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: self.view.frame.size.width  / 2 - 150, y: self.view.frame.size.height / 2 + 50, width: 300, height: 100)
        
        imageView.tag = 100
        
        let today = Date()
         self.calenderView.setDisplayDate(today)
        print("toooday :: \(today)")
         //retriveData(date: today)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(rejectList(req_notification:)), name: NSNotification.Name(rawValue: "pendingDate"), object: nil)
        
    }
    
//    @objc func rejectList(req_notification: NSNotification) {
//
//        var req_id : String = ""
//
//        if let dict = req_notification.userInfo as NSDictionary? {
//            if let date = dict["date"] as? String{
//                print("id="+date)
//                // print("hosp_id="+hosp_id!)
//               // req_id = id
//                retriveData(date: date)
//            }
//
//        }
//    }
    
    
    func setUpCalendar() {
        CalendarView.Style.cellShape                = .bevel(4)
        CalendarView.Style.cellColorDefault         = UIColor.clear
        CalendarView.Style.cellColorToday           = UIColor(red:1.00, green:0.84, blue:0.64, alpha:1.00)
        CalendarView.Style.cellSelectedBorderColor  = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
        CalendarView.Style.cellEventColor           = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
        CalendarView.Style.headerTextColor          = UIColor.white
        CalendarView.Style.cellTextColorDefault     = UIColor.white
        CalendarView.Style.cellTextColorToday       = UIColor(red:0.31, green:0.44, blue:0.47, alpha:1.00)
        //CalendarView.Style.cellEventColor           = UIColor.red
        CalendarView.Style.firstWeekday             = .monday
        
        calenderView.dataSource = self
        calenderView.delegate = self
        
         CalendarView.Style.cellEventColor           = UIColor.red
        
        calenderView.direction = .horizontal
        // calendarView.multipleSelectionEnable = false
        calenderView.marksWeekends = true
        
        calenderView.multipleSelectionEnable = true
        calenderView.backgroundColor = UIColor(red:0.31, green:0.44, blue:0.47, alpha:1.00)
        //        var date = parse("2019-04-10")
        //        calendarView.selectDate(date)
        
        calenderView.loadEvents()
        
    }
    
    func retriveData(completion: @escaping () -> Void) {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
        self.model.removeAll()
        
        SVProgressHUD.show(withStatus: "Loading")
        
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        var id : String = res.value(forKey: "user_id") as! String
        
        print("\(id)")
        
        
        let parameters : [String:String] = [
            
            "partner_id": id
            
            
        ]
        
        Alamofire.request("\(self.url.weburl)/all_pending_products_wrt_partner_id.php", method: .get, parameters: parameters).responseJSON { (response) in
            SVProgressHUD.show(withStatus: "Connecting to server")
            if response.result.isSuccess {
                
                SVProgressHUD.dismiss()
                
                let dataJSON : JSON = JSON(response.result.value!)
                if dataJSON["Status"] != "failed" {
                    if let viewWithTag = self.view.viewWithTag(100) {
                        viewWithTag.removeFromSuperview()
                    }
                    
                    print("counnt :: \(dataJSON.count)")
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
                                
                                let statusModel = LocalModel()
                                
                                
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
                                statusModel.collaborationType = dataJSON[item]["collaborationType"].stringValue
                                self.datarry.append(dataJSON[item]["date"].stringValue)
                                self.model.append(statusModel)
                                //   SVProgressHUD.dismiss()
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.timeStyle = DateFormatter.Style.none
                                dateFormatter.dateFormat = "YYYY-MM-dd"
                                let tody = Date()
                                var dat = dateFormatter.date(from: dataJSON[item]["date"].stringValue)
                                print("date :: \(dat)")
                                if dat! < tody {
                                    
                                   
                                    self.calenderView.addEvent("hello", date: dat!)
                                    print("less")
                                }else if dat! > tody {
                                    print("greater")
                                }
                              
                            }else {
                                print("error not get in first")
                            }
                            
                            //    print("count \(self.model.count)")
                            // SVProgressHUD.dismiss()
                            self.tableView.reloadData()
                            self.tableView.allowsSelection = true
                            
                            
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
                self.retriveData() {
                    
                }
            }
            
        }
        
    }

    // MARK - Retrive data by date
    func retriveData(date:Date) {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
        
        SVProgressHUD.show(withStatus: "Loading")
        
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        var id : String = res.value(forKey: "user_id") as! String
        
        print("\(id)")
        
        
        let parameters : [String:Any] = [
            
            "partner_id": id,
            "applied_on" : date
            
            
        ]
        
        Alamofire.request("\(self.url.weburl)/all_pending_products_wrt_date.php", method: .get, parameters: parameters).responseJSON { (response) in
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
                        
                        let para : [String:Int] = [
                            "id" : dataJSON[item]["collaboration_id"].intValue
                        ]
                        Alamofire.request("\(self.url.weburl)/collabrubImages.php", method: .get, parameters: para).responseJSON { (response) in
                            
                            if response.result.isSuccess {
                                
                                let dataJSON1 : JSON = JSON(response.result.value!)
                                // let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                                //                            print(dataJSON[item])
                                //                             print(dataJSON1)
                                
                                let statusModel = LocalModel()
                                
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
                                statusModel.collaborationType = dataJSON[item]["collaborationType"].stringValue
                                self.model.append(statusModel)
                                self.datarry.append(dataJSON[item]["date"].stringValue)
                                //   SVProgressHUD.dismiss()
                               // print("mss :: \(self.datarry)")
                                
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
                self.retriveData() {
                    
                }
            }
            
        }
    }

    
}



extension PendingProductsViewController : UITableViewDelegate, UITableViewDataSource,CalendarViewDelegate,CalendarViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PendingListTableViewCell
        
        cell.advertisementTitle.text = model[indexPath.row].title
        cell.advertisementDetails.text = model[indexPath.row].description
        cell.usrImg.sd_setImage(with: URL(string: model[indexPath.row].announcementImage))
        cell.typeTag.text = model[indexPath.row].collaborationType
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if model[indexPath.row].collaborationType == "Online" {
        let vc = storyboard?.instantiateViewController(withIdentifier: "allUsersName") as! PendingUserListViewController
        vc.capmpaign_id = model[indexPath.row].collaboration_id
  
        present(vc, animated: true, completion: nil)
        }
      
        
    }
    
    
    //MARK -> Calendar Delegate Methods
    
    
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        
         retriveData(date: date)
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        var dat = dateFormatter.string(from: date)
        print("Did Select: \(dat) ")
        
       // retriveData(date: dat)
        //            var reqDataDict :[String:String]!
        //            reqDataDict = ["date": dat]
        //            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pendingDate"), object: nil, userInfo: reqDataDict)
        
        //        for event in events {
        //            print("\t\"\(event.title)\" - Starting at:\(event.startDate)")
        //        }
        
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        
        return true
    }
    
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didLongPressDate date: Date) {
        
        
    }
    
    func startDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = -3
        
        let today = Date()
        
        let threeMonthsAgo = self.calenderView.calendar.date(byAdding: dateComponents, to: today)!
        
        return threeMonthsAgo
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        
        dateComponents.year = 2;
        let today = Date()
        
        let twoYearsFromNow = self.calenderView.calendar.date(byAdding: dateComponents, to: today)!
        
        return twoYearsFromNow
    }
    
    //    // ENDED

    
}

//extension PendingProductsViewController: {
    
    
//        func setUPDates(){
//            let results : NSArray = try! context.fetch(request) as NSArray
//
//            let res = results[0] as! NSManagedObject
//
//            var id : String = res.value(forKey: "user_id") as! String
//
//            print("\(id)")
//            let date = Date()
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.timeStyle = DateFormatter.Style.none
//            dateFormatter.dateStyle = DateFormatter.Style.short
//            dateFormatter.dateFormat = "YYYY-MM-dd"
//
//            var dat = dateFormatter.string(from: date)
//
//            var today = dateFormatter.date(from: dat)
//            print("today \(date)")
//
//
//            let parameters : [String:String] = [
//
//                "p_id": id
//
//            ]
//
//            Alamofire.request("\(self.url.weburl)/SelectAllDates.php", method: .get, parameters: parameters).responseJSON { (response) in
//               // SVProgressHUD.show(withStatus: "Connecting to server")
//                if response.result.isSuccess {
//
//                  //  SVProgressHUD.dismiss()
//
//                    let dataJSON : JSON = JSON(response.result.value!)
//                    if dataJSON["Status"] != "failed" {
//
//                        print("all count \(dataJSON.count)")
//
//                        for item in 0..<dataJSON.count {
//                            let dateFormatter1 = DateFormatter()
//                            dateFormatter1.dateFormat = "YYYY-MM-dd" //Your date format
//                            dateFormatter1.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
//
//                            var dat = dataJSON[item]["date"].stringValue
//                            var id = dataJSON[item]["collaboration_id"].stringValue
//                           // var dt = dateFormatter.string(from: date)
//
//
//                            var checkdat = dateFormatter1.date(from: dat)
//    //
//                            print("date is \(id) \(checkdat!)")
//
//                            if date.compare(checkdat!) == .orderedAscending {
//                                print("greater \(checkdat!)")
//
//
//
//                             //   self.calenderView.setDisplayDate(checkdat!)
//
//                            }else if date.compare(checkdat!) == .orderedDescending {
//                                print("smaller \(checkdat!)")
//
//
//                                CalendarView.Style.cellColorToday = UIColor.blue
//                            }else if date.compare(checkdat!) == .orderedSame {
//                                print("same \(checkdat!)")
//
//                            }
//                          self.calenderView.selectDate(checkdat!)
//
//
//                        }
//
//
//                    }else {
//
//                    }
//
//                }
//            }
//        }
    
    
//}


