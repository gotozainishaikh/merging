//
//  CollaborationStatusViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 16/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import KDCalendar
import Alamofire
import SwiftyJSON
import CoreData

class CollaborationStatusViewController: UIViewController, CalendarViewDelegate, CalendarViewDataSource {

 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
    let story = UIStoryboard(name: "Main", bundle: nil)
    var model : [StatusTableModel] = [StatusTableModel]()
    
    @IBOutlet weak var calendarView: CalendarView!
    let url = FixVariable()
    @IBOutlet weak var statusTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        statusTable.register(UINib(nibName: "StatusTableViewCell", bundle: nil), forCellReuseIdentifier: "statusCell")
//        retriveData()
       // statusTable.allowsSelection = false
        
        statusTable.separatorStyle = .none
        let button2 = UIBarButtonItem(image: UIImage(named: "bell-icon"), style: .plain, target: self, action: #selector(actionFavList))
        
        self.navigationItem.rightBarButtonItem  = button2
        setUpCalendar()
        
        uiNavegationImage()
    }
    
    @objc func actionFavList(){
        
        let vc = story.instantiateViewController(withIdentifier: "FavList")
        present(vc, animated: true, completion: nil)
        
        
    }
    
    
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
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
        
        calendarView.dataSource = self
        calendarView.delegate = self
        
        
        calendarView.direction = .horizontal
        calendarView.multipleSelectionEnable = false
        calendarView.marksWeekends = true
        
        
        calendarView.backgroundColor = UIColor(red:0.31, green:0.44, blue:0.47, alpha:1.00)
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let today = Date()
        self.calendarView.setDisplayDate(today)
        retriveData(date: today)
        
        
    }
    
    
    
    
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
      //  print("hello")
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        
        retriveData(date: date)
        
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
        
        let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
        
        return threeMonthsAgo
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        
        dateComponents.year = 2;
        let today = Date()
        
        let twoYearsFromNow = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
        
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
    
    func retriveData(date : Date){
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        var dat = dateFormatter.string(from: date)
        print("Did Select: \(dat) ")
        
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        var id : String = res.value(forKey: "user_id") as! String
        
        print("\(id)")
        
        
        let parameters : [String:String] = [
            "date": dat,
            "user_id": id
            
        ]
        
        Alamofire.request("\(self.url.weburl)/calender_date_fetch.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let dataJSON : JSON = JSON(response.result.value!)
                
                let calender = NSCalendar.current
                //      let components = calender.component([.day, .month, .year], from: date)
                //calender.component([.day, .month, .year], from: <#T##Date#>)
                let year = calender.component(.year, from: date)
                let month = calender.component(.month, from: date)
                let day = calender.component(.day, from: date)
                
                
                print(year)
                print(month)
                print(day)
                
                print(dataJSON)
                if dataJSON.count < 1 {
                    self.model.removeAll()
                    self.statusTable.reloadData()
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
                            
                            let statusModel = StatusTableModel()
                            
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
                            statusModel.notification_status = dataJSON[item]["notification_status"].stringValue
                            statusModel.statusDay = day
                            statusModel.statusMonth = self.monthName(month: month)
                            
                            self.model.append(statusModel)
                            //   SVProgressHUD.dismiss()
                            
                        }else {
                            print("error not get in first")
                        }
                        
                        //    print("count \(self.model.count)")
                        // SVProgressHUD.dismiss()
                        self.statusTable.reloadData()
                        
                    }
                    
                    
                }
                
                //                if dataJSON["Status"] == "failed" {
                //                    self.model.removeAll()
                //                    self.statusTable.re
                //                }
                //
                
            }else {
                print("Error in fetching data")
            }
            
        }
        
    }

}
//
extension CollaborationStatusViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "statusCell", for: indexPath) as! StatusTableViewCell
        
        cell.selectionStyle = .none
        
        cell.statusImg.sd_setImage(with: URL(string: model[indexPath.row].announcementImage))
        cell.advertisementHeading.text = model[indexPath.row].title
        cell.statusDescription.text = model[indexPath.row].description
        cell.dateNum.text = String(model[indexPath.row].statusDay)
        cell.monthName.text = model[indexPath.row].statusMonth
        // cell.whatStatus.image = UIImage(named: "14")
     //   print(model[indexPath.row].status)
        if (model[indexPath.row].status == 0) {

            cell.whatStatus.image = UIImage(named: "14.png")

        } else if (model[indexPath.row].status == 1) {

            cell.whatStatus.image = UIImage(named: "12.png")

        } else if (model[indexPath.row].status == 2) {

            cell.whatStatus.image = UIImage(named: "13.png")

        }
        
        
//        cell.reviewerImg.sd_setImage(with: URL(string: model[indexPath.row].reviewerImg) )
//        cell.reviewerName.text = model[indexPath.row].reviewerName
//        cell.ratingLabel.text = "\(model[indexPath.row].reviewRate) - 5"
//        cell.ratings(ratingValue: model[indexPath.row].reviewRate)
//
//        //Image Round
//        cell.statusImg.layer.cornerRadius = cell.statusImg.frame.size.width/2
//        cell.statusImg.clipsToBounds = true

        
        
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "statDetails" {
            let destinationVC = segue.destination as! LocalDetailsViewController
            destinationVC.statArray = (sender as? StatusTableModel!)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.performSegue(withIdentifier: "statDetails", sender: model[(indexPath.row)])
        
    }
    
    
}
