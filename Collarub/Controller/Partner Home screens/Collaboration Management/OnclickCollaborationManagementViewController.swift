//
//  OnclickCollaborationManagementViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 02/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import KDCalendar
import CoreData
import Alamofire
import SwiftyJSON

class OnclickCollaborationManagementViewController: UIViewController,PageViewControllerDelegate {

    let story = UIStoryboard(name: "Main", bundle: nil)
    @IBOutlet weak var pendingBtn: UIButton!
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var findInfluencerBtn: UIButton!
    @IBOutlet weak var pageView: UIView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
    let url = FixVariable()
    
    var pageViewController:PageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        setUpCalendar()
       callingInViewDidLoad()
       // pageViewController?.delegate = nil
        self.pageViewController?.delegate = nil
        self.pageViewController?.dataSource = nil
        
    }
    
    func borderBtn(btn : UIButton){
        
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor(named: "ThemeColor1")?.cgColor
    }
    
    func callingInViewDidLoad(){
        
        pendingBtn.titleLabel?.textAlignment = .center
        pendingBtn.titleLabel?.numberOfLines = 0
        historyBtn.titleLabel?.textAlignment = .center
        historyBtn.titleLabel?.numberOfLines = 0
        findInfluencerBtn.titleLabel?.textAlignment = .center
        findInfluencerBtn.titleLabel?.numberOfLines = 0
        
        borderBtn(btn: pendingBtn)
        borderBtn(btn: historyBtn)
        borderBtn(btn: findInfluencerBtn)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let today = Date()
       // self.calenderView.setDisplayDate(today)
        print("toooday :: \(today)")
        //retriveData(date: today)
        
        
    }
    
    
    @IBAction func historyClick(_ sender: UIButton) {
        pageViewController?.moveToPage(index: 1)
        
        changeTab(btn1: sender, btn2: pendingBtn, btn3: findInfluencerBtn)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setcalandar"), object: nil, userInfo: nil)
        
    }
    
    @IBAction func pendingCLick(_ sender: UIButton) {
        
        pageViewController?.moveToPage(index: 0)

                changeTab(btn1: sender, btn2: historyBtn, btn3: findInfluencerBtn)
        
        
    }
    
    @IBAction func influencerClick(_ sender: UIButton) {
        
         pageViewController?.moveToPage(index: 2)
        
        changeTab(btn1: sender, btn2: pendingBtn, btn3: historyBtn)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setcalandar"), object: nil, userInfo: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let _pageViewController = segue.destination as? PageViewController {
            _pageViewController.viewControllerIdentifiers = ["pendingView","history","findInfluencer"]
            
            _pageViewController.pageDelegate = nil
            
            self.pageViewController = _pageViewController
            
            
            
            
        }
    }
    
    
//
//    func setUpCalendar() {
//
//        CalendarView.Style.cellShape                = .bevel(4)
//        CalendarView.Style.cellColorDefault         = UIColor.clear
//        CalendarView.Style.cellColorToday           = UIColor.red
//        CalendarView.Style.cellSelectedBorderColor  = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
//        CalendarView.Style.cellEventColor           = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
//        CalendarView.Style.headerTextColor          = UIColor.white
//        CalendarView.Style.cellTextColorDefault     = UIColor.white
//        CalendarView.Style.cellTextColorToday       = UIColor.white
//
//        CalendarView.Style.firstWeekday             = .monday
//        calenderView.multipleSelectionEnable = true
//
//        calenderView.dataSource = self
//        calenderView.delegate = self
//
//
//        calenderView.direction = .horizontal
//        calenderView.multipleSelectionEnable = false
//        calenderView.marksWeekends = true
//
//        calenderView.backgroundColor = UIColor(red:0.31, green:0.44, blue:0.47, alpha:1.00)
//
//        setUPDates()
//
//
//    }
//
//    func setUPDates(){
//        let results : NSArray = try! context.fetch(request) as NSArray
//
//        let res = results[0] as! NSManagedObject
//
//        var id : String = res.value(forKey: "user_id") as! String
//
//        print("\(id)")
//        let date = Date()
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = DateFormatter.Style.none
//        dateFormatter.dateStyle = DateFormatter.Style.short
//        dateFormatter.dateFormat = "YYYY-MM-dd"
//
//        var dat = dateFormatter.string(from: date)
//
//        var today = dateFormatter.date(from: dat)
//        print("today \(date)")
//
//
//        let parameters : [String:String] = [
//
//            "p_id": id
//
//        ]
//
//        Alamofire.request("\(self.url.weburl)/SelectAllDates.php", method: .get, parameters: parameters).responseJSON { (response) in
//           // SVProgressHUD.show(withStatus: "Connecting to server")
//            if response.result.isSuccess {
//
//              //  SVProgressHUD.dismiss()
//
//                let dataJSON : JSON = JSON(response.result.value!)
//                if dataJSON["Status"] != "failed" {
//
//                    print("all count \(dataJSON.count)")
//
//                    for item in 0..<dataJSON.count {
//                        let dateFormatter1 = DateFormatter()
//                        dateFormatter1.dateFormat = "YYYY-MM-dd" //Your date format
//                        dateFormatter1.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
//
//                        var dat = dataJSON[item]["date"].stringValue
//                        var id = dataJSON[item]["collaboration_id"].stringValue
//                       // var dt = dateFormatter.string(from: date)
//
//
//                        var checkdat = dateFormatter1.date(from: dat)
////
//                        print("date is \(id) \(checkdat!)")
//
//                        if date.compare(checkdat!) == .orderedAscending {
//                            print("greater \(checkdat!)")
//
//
//
//                         //   self.calenderView.setDisplayDate(checkdat!)
//
//                        }else if date.compare(checkdat!) == .orderedDescending {
//                            print("smaller \(checkdat!)")
//
//
//                            CalendarView.Style.cellColorToday = UIColor.blue
//                        }else if date.compare(checkdat!) == .orderedSame {
//                            print("same \(checkdat!)")
//
//                        }
//                      self.calenderView.selectDate(checkdat!)
//
//
//                    }
//
//
//                }else {
//
//                }
//
//            }
//        }
//    }

    
    //MARK -> Calendar Delegate Methods
    
//
//    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
//        //  print("hello")
//    }
//
//    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
//
//        // retriveData(date: date)
//        print(date)
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = DateFormatter.Style.none
//        dateFormatter.dateFormat = "YYYY-MM-dd"
//
//        var dat = dateFormatter.string(from: date)
//        print("Did Select: \(dat) ")
//
//        var reqDataDict :[String:String]!
//        reqDataDict = ["date": dat]
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pendingDate"), object: nil, userInfo: reqDataDict)
//
//        //        for event in events {
//        //            print("\t\"\(event.title)\" - Starting at:\(event.startDate)")
//        //        }
//
//    }
//
//    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
//
//        return true
//    }
//
//    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
//
//    }
//
//    func calendar(_ calendar: CalendarView, didLongPressDate date: Date) {
//
//
//    }
//
//    func startDate() -> Date {
//        var dateComponents = DateComponents()
//        dateComponents.month = -3
//
//        let today = Date()
//
//        let threeMonthsAgo = self.calenderView.calendar.date(byAdding: dateComponents, to: today)!
//
//        return threeMonthsAgo
//    }
//
//    func endDate() -> Date {
//        var dateComponents = DateComponents()
//
//        dateComponents.year = 2;
//        let today = Date()
//
//        let twoYearsFromNow = self.calenderView.calendar.date(byAdding: dateComponents, to: today)!
//
//        return twoYearsFromNow
//    }
//
//    // ENDED
    
    func changeTab(btn1 : UIButton, btn2 : UIButton, btn3 : UIButton){

        
        btn1.setTitleColor(UIColor.white, for: .normal)
        btn1.backgroundColor = UIColor(named: "themecolor4")
        
        btn2.setTitleColor(UIColor(named: "themecolor4"), for: .normal)
        btn2.backgroundColor = UIColor.white
        btn2.layer.borderWidth = 0.5
        btn2.layer.borderColor = UIColor(named: "ThemeColor1")?.cgColor
        
        btn3.setTitleColor(UIColor(named: "themecolor4"), for: .normal)
        btn3.backgroundColor = UIColor.white
        btn3.layer.borderWidth = 0.5
        btn3.layer.borderColor = UIColor(named: "ThemeColor1")?.cgColor
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, didUpdatePageIndex index: Int) {
        //self.animateBottomBar(index: index)
        print("hello")
        UIView.animate(withDuration: 0.2) {
        }
        
        if index == 0 {
            // changeTab(btn1: localAnnouncement, btn2: onlineAnnouncement)
            
        }else {
            // changeTab(btn1: onlineAnnouncement, btn2: localAnnouncement)
        }
        
    }
    
    

}

