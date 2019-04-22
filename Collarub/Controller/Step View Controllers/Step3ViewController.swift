//
//  Step3ViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 15/02/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import iOSDropDown
import Alamofire
import SwiftyJSON


class Step3ViewController: UIViewController {

    var engagementRt : String = ""
    var lCity : String = ""
    var lRegion : String = ""
    var reputationLvl : String = ""
    var exLevel : String = ""
    var gndr : String = ""
    var follwrLimt : String = ""
    let url = FixVariable()
    
    @IBOutlet weak var sector: DropDown!
    var stat_id : String = ""
    var con_id = [Int]()
    @IBOutlet weak var engagementRateDrop: DropDown!
    @IBOutlet weak var citDrop: DropDown!
    @IBOutlet weak var regionDrop: DropDown!
    @IBOutlet weak var ratingText: UITextField!
    @IBOutlet weak var minExperience: UITextField!
    @IBOutlet weak var genderDrop: DropDown!
    @IBOutlet weak var fllowersLimt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        engagementRateDrop.selectedRowColor = UIColor.lightGray
        citDrop.selectedRowColor = UIColor.lightGray
        regionDrop.selectedRowColor = UIColor.lightGray
        genderDrop.selectedRowColor = UIColor.lightGray
        
        NotificationCenter.default.addObserver(self, selector: #selector(rejectList(req_notification:)), name: NSNotification.Name(rawValue: "reqreject"), object: nil)
        
        stateRetrieve()
        
        engagementRateDrop.optionArray = ["10%", "20%", "50%","100%"]
        
        sector.optionArray = ["Sports", "Foods", "Fashion","Beauty & Health","Events","Travel","Digital & Devices","Perenting","Home & Decor","Automotive","Pets"]
        
        
//        citDrop.optionArray = ["London", "Canada", "Sydney"]
//        citDrop.optionIds = [1,4,3]
        genderDrop.optionArray = ["Male", "Female"]
        
        
        // MARK - Drop Down selecting
        engagementRateDrop.arrowSize = 10
        
        
        engagementRateDrop.didSelect{(selectedText , index , id) in
                      //  print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            self.engagementRt = selectedText
           // self.selectedtex = selectedText
        }
        
        regionDrop.arrowSize = 10
        regionDrop.didSelect{(selectedText , index , id) in
          //  print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            self.lRegion = selectedText
         //   print(self.con_id[index-1])
            
            self.citiesName(nam: selectedText)
            
            // self.selectedtex = selectedText
        }
        
        genderDrop.arrowSize = 10
        genderDrop.didSelect{(selectedText , index , id) in
          //  print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            
            self.gndr = selectedText
            // self.selectedtex = selectedText
        }
        
        citDrop.arrowSize = 10
        citDrop.didSelect{(selectedText , index , id) in
          //  print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            self.lCity = selectedText
            
            // self.selectedtex = selectedText
        }
        
        self.borederTodrop(drop: engagementRateDrop)
        self.borederTodrop(drop: regionDrop)
        self.borederTodrop(drop: citDrop)
        self.borederTodrop(drop: genderDrop)
        self.borederTodrop(drop: sector)
        self.borederTotext(textfield: ratingText)
        self.borederTotext(textfield: minExperience)
        self.borederTotext(textfield: fllowersLimt)
        
        
    }
    
    @objc func rejectList(req_notification: NSNotification) {
        var req_id : String = ""
        
        if let dict = req_notification.userInfo as NSDictionary? {
            if let id = dict["json"] as? JSON{
               // print("id zain shaikh :::: \(id[0]["followers_limit"])")
                
                if let engrt = id[0]["engagement_rate"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if engrt != ""{
                       
                        self.engagementRt = engrt
                        engagementRateDrop.text = engrt
                        
                    }
                }
                if let rqCity = id[0]["required_city"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if rqCity != ""{
                        
                        self.lCity = rqCity
                        citDrop.text = rqCity
                        
                    }
                }
                
                if let rqRegion = id[0]["required_region"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if rqRegion != ""{
                        
                        self.lRegion = rqRegion
                        regionDrop.text = rqRegion
                        
                    }
                }
                
                if let minrt = id[0]["min_user_rating"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if minrt != ""{
                        
                        self.reputationLvl = minrt
                        ratingText.text = minrt
                        
                    }
                }
                
                if let minEx = id[0]["min_user_exp_level"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if minEx != ""{
                        
                        self.exLevel = minEx
                        minExperience.text = minEx

                    }
                }
                
                if let gnd = id[0]["user_gender"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if gnd != ""{
                        
                        self.gndr = gnd
                        genderDrop.text = gnd
                        
                    }
                }
                
                if let flwr = id[0]["followers_limit"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if flwr != ""{
                        
                        self.follwrLimt = flwr
                        fllowersLimt.text = flwr
                        
                    }
                }
                
                
            }
        }
    }
    
    func citiesName (nam : String){
    
        let parameters : [String:String] = [
            "state_name": "\(nam)"
        ]
        
        
        Alamofire.request("\(self.url.weburl)/cities_name.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            
            if response.result.isSuccess {
                let dataJSON : JSON = JSON(response.result.value!)
                print(dataJSON)
                
                for item in 0..<dataJSON.count {
                    
                    print(dataJSON[item]["id"])
                    
                    self.regionDrop.optionArray.append(dataJSON[item]["name"].stringValue)
                    self.citDrop.optionArray.append(dataJSON[item]["name"].stringValue)
                    //self.con_id.append(dataJSON[item]["id"].intValue)
                    
                }
            }
            
        }
        
    }
    func stateRetrieve() {
        
        Alamofire.request("\(self.url.weburl)/get_all_states.php", method: .get).responseJSON { (response) in
            
            
            if response.result.isSuccess {
                let dataJSON : JSON = JSON(response.result.value!)
                print(dataJSON)
                
                for item in 0..<dataJSON.count {
                    
                    print(dataJSON[item]["id"])
                    
                    self.regionDrop.optionArray.append(dataJSON[item]["name"].stringValue)
                   
                    
                }
            }
            
        }
        
    }
    
    @IBAction func textRat(_ sender: UITextField) {
        reputationLvl = ratingText.text!
    }
    
    @IBAction func textExprnceLevel(_ sender: UITextField) {
        exLevel = minExperience.text!
    }
    
    
    func borederTodrop(drop : DropDown){
        
        drop.layer.borderWidth = 1
        drop.layer.borderColor = UIColor.white.cgColor
    }
    
    func borederTotext(textfield : UITextField){
        
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func follwrsLimit(_ sender: UITextField) {
        follwrLimt = sender.text!
    }
    
    
    
    
    @IBAction func dropList(_ sender: Any) {
        engagementRateDrop.touchAction()
    }
    
    @IBAction func asa(_ sender: UITextField) {
    }
}
