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
import GooglePlacesSearchController
import TTGSnackbar

class Step3ViewController: UIViewController {

    var engagementRt : String = ""
    var lCity : String = ""
    var lRegion : String = ""
    var reputationLvl : String = ""
    var exLevel : String = ""
    var gndr : String = ""
    var follwrLimt : String = ""
    let url = FixVariable()
    var Age1 : String!
    
    @IBOutlet weak var regionTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var sector: DropDown!
    var stat_id : String = ""
    var con_id = [Int]()
    @IBOutlet weak var engagementRateDrop: DropDown!
    @IBOutlet weak var ratingText: UITextField!
    @IBOutlet weak var minExperience: UITextField!
    @IBOutlet weak var genderDrop: DropDown!
    @IBOutlet weak var fllowersLimt: UITextField!
    
    @IBOutlet weak var age1: DropDown!
    @IBOutlet weak var age2: DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        engagementRateDrop.selectedRowColor = UIColor.lightGray
       
        genderDrop.selectedRowColor = UIColor.lightGray
        
        NotificationCenter.default.addObserver(self, selector: #selector(rejectList(req_notification:)), name: NSNotification.Name(rawValue: "reqreject"), object: nil)
        
        stateRetrieve()
        
        engagementRateDrop.optionArray = ["10%", "20%", "50%","100%"]
        
        sector.optionArray = ["Sports", "Foods", "Fashion","Beauty & Health","Events","Travel","Digital & Devices","Perenting","Home & Decor","Automotive","Pets"]
        
         age2.optionArray = ["5 years", "10 years", "15 years", "20 years", "30 years", "40 years", "50 years", "60 years", "70 years"]
         age1.optionArray = ["5 years", "10 years", "15 years", "20 years", "30 years", "40 years", "50 years", "60 years", "70 years"]
        
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
        
        age2.didSelect{(selectedText , index , id) in
            
            if self.Age1 == nil {
                let snackbar = TTGSnackbar(message: "Please select starting age", duration: .short)
                snackbar.show()
            }
           
            
        }
        
        age1.didSelect{(selectedText , index , id) in
            
            self.Age1 = selectedText
            
        }
        
        
        
       
        
        genderDrop.arrowSize = 10
        genderDrop.didSelect{(selectedText , index , id) in
          //  print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            
            self.gndr = selectedText
            // self.selectedtex = selectedText
        }
        
      
        
        self.borederTodrop(drop: engagementRateDrop)
        
        self.borederTodrop(drop: genderDrop)
        self.borederTodrop(drop: sector)
        self.borederTotext(textfield: ratingText)
        self.borederTotext(textfield: age1)
        self.borederTotext(textfield: age2)
        self.borederTotext(textfield: minExperience)
        self.borederTotext(textfield: fllowersLimt)
        self.borederTotext(textfield: cityTxt)
        self.borederTotext(textfield: regionTxt)
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
                       // citDrop.text = rqCity
                        cityTxt.text = rqCity
                    }
                }
                
                if let rqRegion = id[0]["required_region"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if rqRegion != ""{
                        
                        self.lRegion = rqRegion
                       // regionDrop.text = rqRegion
                        
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
    
//        let parameters : [String:String] = [
//            "state_name": "\(nam)"
//        ]
//        
//        
//        Alamofire.request("\(self.url.weburl)/cities_name.php", method: .get, parameters: parameters).responseJSON { (response) in
//            
//            
//            if response.result.isSuccess {
//                let dataJSON : JSON = JSON(response.result.value!)
//                print(dataJSON)
//                
//                for item in 0..<dataJSON.count {
//                    
//                    print(dataJSON[item]["id"])
//                    
//                    self.regionDrop.optionArray.append(dataJSON[item]["name"].stringValue)
//                    self.citDrop.optionArray.append(dataJSON[item]["name"].stringValue)
//                    //self.con_id.append(dataJSON[item]["id"].intValue)
//                    
//                }
//            }
//            
//        }
        
    }
    func stateRetrieve() {
        
//        Alamofire.request("\(self.url.weburl)/get_all_states.php", method: .get).responseJSON { (response) in
//
//
//            if response.result.isSuccess {
//                let dataJSON : JSON = JSON(response.result.value!)
//                print(dataJSON)
//
//                for item in 0..<dataJSON.count {
//
//                    print(dataJSON[item]["id"])
//
//                    self.regionDrop.optionArray.append(dataJSON[item]["name"].stringValue)
//
//
//                }
//            }
//
//        }
        
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
    
    
    @IBAction func cityOnClick(_ sender: UITextField) {
       stat = true
        present(placesSearchController, animated: true, completion: nil)
    }
    
    @IBAction func cityEndEditing(_ sender: UITextField) {
        
    }
    
    @IBAction func regionEditBegin(_ sender: UITextField) {
        stat = false
        present(placesSearchController1, animated: true, completion: nil)
    }
    
    @IBAction func regionEndEdit(_ sender: UITextField) {
    }
    
    @IBAction func dropList(_ sender: Any) {
        engagementRateDrop.touchAction()
    }
    
    @IBAction func asa(_ sender: UITextField) {
    }
    
    let GoogleMapsAPIServerKey = "AIzaSyCp93QINHvSoa0pdd1jK-oOsCZsZjAeQVI"
    
    lazy var placesSearchController: GooglePlacesSearchController = {
        let controller = GooglePlacesSearchController(delegate: self,
                                                      apiKey: GoogleMapsAPIServerKey,
                                                      placeType: .cities
            
        )
        
        return controller
    }()
    var stat : Bool!
    lazy var placesSearchController1: GooglePlacesSearchController = {
        let controller = GooglePlacesSearchController(delegate: self,
                                                      apiKey: GoogleMapsAPIServerKey,
                                                      placeType: .regions
            
        )
        
        return controller
    }()
    
}


extension Step3ViewController: GooglePlacesAutocompleteViewControllerDelegate {
    func viewController(didAutocompleteWith place: PlaceDetails) {
        
        print(place.description)
        if stat {
            cityTxt.text = place.name!
            lCity = place.name!
            print("stt :: \(place.name)")
            placesSearchController.isActive = false
        }else if !stat {
            regionTxt.text = place.name!
            lRegion = place.name!
            print("stt :: \(place.name)")
            placesSearchController1.isActive = false
        }
      
        
    }
}
