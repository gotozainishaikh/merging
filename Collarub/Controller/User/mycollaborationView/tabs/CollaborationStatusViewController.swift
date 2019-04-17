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
    
    var req_status = "3"
    let apiCall  = AlamofireApi()
    
    var arrModel:[UserRequestModel] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
    let story = UIStoryboard(name: "Main", bundle: nil)
    var model : [StatusTableModel] = [StatusTableModel]()
    
    
    @IBAction func complete_btn_click(_ sender: UIButton) {
        
        self.arrModel.removeAll()
        print("complete")
        req_status = "1"
        self.viewDidLoad()
    }
    
    
    @IBAction func in_complete_btn_click(_ sender: UIButton) {
        
        self.arrModel.removeAll()
        print("in-complete")
        req_status = "3"
        self.viewDidLoad()
    }
    
    @IBAction func pending_btn_click(_ sender: UIButton) {
        
        self.arrModel.removeAll()
        print("pending")
        req_status = "2"
        self.viewDidLoad()
    }
    
    @IBAction func decline_btn_click(_ sender: UIButton) {
      
        self.arrModel.removeAll()
        print("decline")
        req_status = "4"
        self.viewDidLoad()
    }
    
    
    @IBOutlet weak var calendarView: CalendarView!
    let url = FixVariable()
    @IBOutlet weak var statusTable: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("arrModel.count=\(arrModel.count))")
        for item in self.arrModel{
            
            print("arrModel[0].get_applied_on()=\(item.get_applied_on())")
            self.calendarView.reloadData()
            if(item.get_applied_on() != ""){
                var date = self.parse(item.get_applied_on())
                
                self.calendarView.deselectDate(date)
            }
        }
        
        print("req_status=\(req_status)")
        // Do any additional setup after loading the view.
        
        statusTable.register(UINib(nibName: "StatusTableViewCell", bundle: nil), forCellReuseIdentifier: "statusCell")
        //        retriveData()
        // statusTable.allowsSelection = false
        
        statusTable.separatorStyle = .none
        let button2 = UIBarButtonItem(image: UIImage(named: "bell-icon"), style: .plain, target: self, action: #selector(actionFavList))
        
        self.navigationItem.rightBarButtonItem  = button2
        setUpCalendar()
        //        var date = parse("2019-04-12")
        //        calendarView.addEvent("hello", date: date)
        
        uiNavegationImage()
        
        
        
        
        getAllRequest(status_id: req_status){
            
            print("self.arrModelaxy=\(self.arrModel.count)")
            for item in self.arrModel{
                
                print("arrModel[0].get_applied_on()=\(item.get_applied_on())")
               
                if(item.get_applied_on() != ""){
                    var date = self.parse(item.get_applied_on())
                    
                    self.calendarView.selectDate(date)
                }
            }
            
            print("reaload table")
            self.statusTable.reloadData()
        }
        
        
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
        // calendarView.multipleSelectionEnable = false
        calendarView.marksWeekends = true
        
        calendarView.multipleSelectionEnable = true
        calendarView.backgroundColor = UIColor.black
        //        var date = parse("2019-04-10")
        //        calendarView.selectDate(date)
        
        
    }
    func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
       
        let dateFormatter = DateFormatter()
        
       // var date = Date()
       
        
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: string)!
//        if let temp = dateFormatter.date(from: string){
//            print("temp date = \(temp)")
//            date = temp
//        }
        return date
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let today = Date()
        //print("dateabc=\(today)")
        self.calendarView.setDisplayDate(today)
        //retriveData(date: today)
        //
        //        var date1 = parse("2019-04-13")
        //        self.calendarView.selectDate(date1)
        //
        //        var date2 = parse("2019-04-16")
        //        self.calendarView.selectDate(date2)
        //        //self.calendarView.
        
        
        
        
        
    }
    
    
    
    
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
        //  print("hello")
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        
        print("selected date=\(date)")
        //retriveData(date: date)
        
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
    
    
    func getAllRequest(status_id:String,completion: @escaping () -> Void){
        
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        var id : String = res.value(forKey: "user_id") as! String
        
        let parameters : [String:String] = [
            "status_id": status_id,
            "user_id": id
            
            
        ]
        
        
        apiCall.alamofireApiWithParams(url: "\(self.url.weburl)/get_all_pending_requests.php", parameters: parameters){
            
            json in
            
            print("STATUSabc\(json["Status"])")
            var i:Int = 0
            if(json["Status"] != "failed"){
                for item in 0..<json.count {
               
                
                let userRequestModel = UserRequestModel()
                print("colabidabc\(json[item]["collaboration_id"].stringValue)")
                
                let parameters : [String:String] = [
                    "id" : json[item]["collaboration_id"].stringValue
                ]
                
                self.apiCall.alamofireApiWithParams(url:  "\(self.url.weburl)/collabrubImages.php", parameters: parameters){
                    
                    json2 in
                    
                    
                    
                    //print("json2=\(json2[0]["img_url"].stringValue)")
                    
                    userRequestModel.set_request_data(json: json[item], json2: json2)
                    
                    self.arrModel.append(userRequestModel)
                    i = i + 1
                    //print("i=\(i)")
                    if(i>=json.count){
                       // print("completion()=\(json.count)")
                        completion()
                        
                    }
                    
                }
                
                
            }
            }
            else{
                completion()

            }
//            completion()
            
        }
        
    }
    
}
//
extension CollaborationStatusViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "statusCell", for: indexPath) as! StatusTableViewCell
        
        cell.selectionStyle = .none
        
        cell.statusImg.sd_setImage(with: URL(string: arrModel[indexPath.row].get_announcementImage()))
        cell.advertisementHeading.text = arrModel[indexPath.row].get_collaboration_name()
        cell.statusDescription.text = arrModel[indexPath.row].get_descriptions()
        cell.dateNum.text = arrModel[indexPath.row].get_applied_on()
        
        //        cell.monthName.text = model[indexPath.row].statusMonth
        //        // cell.whatStatus.image = UIImage(named: "14")
        //     //   print(model[indexPath.row].status)
        //        if (model[indexPath.row].status == 0) {
        //
        //            cell.whatStatus.image = UIImage(named: "14.png")
        //
        //        } else if (model[indexPath.row].status == 1) {
        //
        //            cell.whatStatus.image = UIImage(named: "12.png")
        //
        //        } else if (model[indexPath.row].status == 2) {
        //
        //            cell.whatStatus.image = UIImage(named: "13.png")
        //
        //        }
        
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
            let destinationVC = segue.destination as! Agenda
            destinationVC.statArray = (sender as? UserRequestModel!)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.performSegue(withIdentifier: "statDetails", sender: arrModel[(indexPath.row)])
        
    }
    
    
    
    
}
