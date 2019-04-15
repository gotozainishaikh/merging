//
//  CompletedHistoryViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 04/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SVProgressHUD
import SwiftyJSON
import KDCalendar

class CompletedHistoryViewController: UIViewController, CalendarViewDelegate, CalendarViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var calenderView: CalendarView!
    var model : [FavListModel] = [FavListModel]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
    let url = FixVariable()
    var isCheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(loadList(req_notification:)), name: NSNotification.Name(rawValue: "setcalandar"), object: nil)
        
        tableView.register(UINib(nibName: "FavCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        let today = Date()
        self.calenderView.setDisplayDate(today)
        
        if !isCheck {
            backBtn.isHidden = true
        }
        
    }
    
    @objc func loadList(req_notification: NSNotification) {
        
        let today = Date()
        self.calenderView.setDisplayDate(today)
    }
    
    
    func setUpCalendar() {
        
        CalendarView.Style.cellShape                = .bevel(4)
        CalendarView.Style.cellColorDefault         = UIColor.clear
        CalendarView.Style.cellColorToday           = UIColor(red:1.00, green:0.84, blue:0.64, alpha:1.00)
        CalendarView.Style.cellSelectedBorderColor  = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
        CalendarView.Style.cellEventColor           = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
        CalendarView.Style.headerTextColor          = UIColor.white
        CalendarView.Style.cellTextColorDefault     = UIColor.white
        CalendarView.Style.cellTextColorToday       = UIColor(red:0.31, green:0.44, blue:0.47, alpha:1.00)
        
        
        CalendarView.Style.firstWeekday             = .monday
        
        
        calenderView.dataSource = self
        calenderView.delegate = self
        
        
        calenderView.direction = .horizontal
        // calendarView.multipleSelectionEnable = false
        calenderView.marksWeekends = true
        
        calenderView.multipleSelectionEnable = false
        calenderView.backgroundColor = UIColor.black
        //        var date = parse("2019-04-10")
        //        calendarView.selectDate(date)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retriveData()
        setUpCalendar()
        
        let today = Date()
        calenderView.setDisplayDate(today)
    }
    
    
    
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
        //  print("hello")
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        
       // retriveData(date: date)
        
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
    
    func monthName(month:Int)->String {
        
        var monthNam : String = ""
        if(month == 1) {
            monthNam = "JANUARY"
            
        } else if(month == 2){
            monthNam = "FEBRUARY"
        } else if(month == 3){
            monthNam = "MARCH"
        } else if(month == 4){
            monthNam = "APRIL"
        } else if(month == 5){
            monthNam = "MAY"
        } else if(month == 6){
            monthNam = "JUNE"
        } else if(month == 7){
            monthNam = "JULY"
        } else if(month == 8){
            monthNam = "AUGUST"
        } else if(month == 9){
            monthNam = "SEPTEMBER"
        } else if(month == 10){
            monthNam = "OCTOBER"
        } else if(month == 11){
            monthNam = "NOVEMBER"
        } else if(month == 12){
            monthNam = "DECEMBER"
        }
        
        return monthNam
        
    }
    
    
    
    func retriveData(){
        
         SVProgressHUD.show(withStatus: "Loading")
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        var id : String = res.value(forKey: "user_id") as! String
        
        print("\(id)")
        
        
        let parameters : [String:String] = [
            
            "partner_id": id
            
        ]
        
        Alamofire.request("\(self.url.weburl)/get_completed_users.php", method: .get, parameters: parameters).responseJSON { (response) in
            SVProgressHUD.show(withStatus: "Connecting to server")
            if response.result.isSuccess {
                
                SVProgressHUD.dismiss()
                
                let dataJSON : JSON = JSON(response.result.value!)
                if dataJSON["Status"] != "failed" {
                    
                    
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
                                statusModel.url = dataJSON[item]["urls"].stringValue
                                statusModel.user_give_review = dataJSON[item]["review"].stringValue
                                statusModel.user_give_rating = dataJSON[item]["rate"].stringValue
                                statusModel.user_id = dataJSON[item]["user_id"].stringValue
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
                    
                    self.model.removeAll()
                    self.tableView.reloadData()
                }
                
            }else {
                print("Error in fetching data")
                self.retriveData()
            }
            
        }
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension CompletedHistoryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavCellTableViewCell
        
        cell.advertisementTitle.text = model[indexPath.row].title
        cell.advertisementDetails.text = model[indexPath.row].description
         cell.usrImg.sd_setImage(with: URL(string: model[indexPath.row].announcementImage))
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(model[indexPath.row].collaboration_id)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "showUserReview") as! CampaignEditViewController
        vc.model = model[indexPath.row]
        present(vc, animated: true, completion: nil)
        
        
        
        
        //  self.performSegue(withIdentifier: "requestList", sender: nil)
        
    }
    
    
    
    
}
