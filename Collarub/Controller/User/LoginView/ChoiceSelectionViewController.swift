//
//  ChoiceSelectionViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 12/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import CheckBox
import iOSDropDown
import GooglePlacesSearchController
import CoreData
import KWVerificationCodeView
import SwiftyJSON
import Alamofire
import SVProgressHUD

class ChoiceSelectionViewController: UIViewController {

    @IBOutlet weak var foodCheck: CheckBox!
    @IBOutlet weak var sportsCheck: CheckBox!
    @IBOutlet weak var fashionCheck: CheckBox!
    @IBOutlet weak var beautyCheck: CheckBox!
    @IBOutlet weak var eventsCheck: CheckBox!
    @IBOutlet weak var travelCheck: CheckBox!
    @IBOutlet weak var digitalCheck: CheckBox!
    @IBOutlet weak var parentingCheck: CheckBox!
    @IBOutlet weak var homeCheck: CheckBox!
    @IBOutlet weak var automatCheck: CheckBox!
    @IBOutlet weak var petCheck: CheckBox!
    @IBOutlet weak var categoryDrop: DropDown!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var verificationCode: KWVerificationCodeView!
    
    var country:String = ""
    var city:String = ""
    var address:String = ""
    var category:String = ""
    var count = 1
    var choice1:String = ""
    var choice2:String = ""
    
    var dataJson : JSON!
    var followers : Int!
    var authToken : String!
    var user_id : String!
    
    
    var api = AlamofireApi()
    var base_url = FixVariable()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryDrop.layer.borderWidth = 1
        categoryDrop.layer.borderColor = UIColor.white.cgColor
        
        mailText.layer.borderWidth = 1
        mailText.layer.borderColor = UIColor.white.cgColor
        
        
        locationText.layer.borderWidth = 1
        locationText.layer.borderColor = UIColor.white.cgColor
        
        categoryDrop.optionArray = ["Influencer/Blogger", "Singer", "Dancer","Model","Athlete","Actor","Youtuber","Photographer","Filmaker","Write/Author","Stylist","Public Personality"]
        
        // MARK - Drop Down selecting
        categoryDrop.arrowSize = 10
        categoryDrop.didSelect{(selectedText , index , id) in
            print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            
            self.category = selectedText
          //  self.categoryDrop = selectedText
            // self.selectedtex = selectedText
        }
        
        foodCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.foodCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    
                    if(self.choice1==""){
                        self.choice1 = self.foodCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.foodCheck.title!
                    }
                    
                }else {
                    checked.isChecked = false
                   
                }
              
                
            }else {
                self.count -= 1
                print(self.count)
                
                if(self.choice2 == self.foodCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.foodCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        sportsCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.sportsCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.sportsCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.sportsCheck.title!
                    }
                    
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.sportsCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.sportsCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        fashionCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.fashionCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.fashionCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.fashionCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.fashionCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.fashionCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        beautyCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.fashionCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.fashionCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.fashionCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.fashionCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.fashionCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        eventsCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.eventsCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.eventsCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.eventsCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.eventsCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.eventsCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        travelCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.travelCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.travelCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.travelCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.travelCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.travelCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        digitalCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.digitalCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.digitalCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.digitalCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.digitalCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.digitalCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        
        parentingCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.parentingCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.parentingCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.parentingCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.parentingCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.parentingCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        
        homeCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.homeCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.homeCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.homeCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.homeCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.homeCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        
        automatCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.automatCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.automatCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.automatCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.automatCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.automatCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        
        petCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.petCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.petCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.petCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.petCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.petCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        
        
        
    }
    
    
    @IBAction func location_edit(_ sender: UITextField) {
        
        present(placesSearchController, animated: true, completion: nil)
        
    }
    
    @IBAction func cont_btn(_ sender: UIButton) {
        
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
//
//        let results : NSArray = try! context.fetch(request) as NSArray
//
//        let res = results[0] as! NSManagedObject
//
//        var user_id : String = res.value(forKey: "user_id") as! String
//
        
        print("choice1=\(choice1)")
        print("choice2=\(choice2)")
        print("location.text=\(locationText.text!)")
        print("category.text=\(category)")
        print("email.text=\(mailText.text!)")
        print("address=\(address)")
        print("city=\(city)")
        print("country=\(country)")
        
        
        var url = "\(base_url.weburl)/zain_user_registeration.php"
       
        print("verificationCode :: \(verificationCode.getVerificationCode())")
        
        var code : String = ""
        if verificationCode.hasValidCode() {
            code = verificationCode.getVerificationCode()
        }
        print("codee :: \(code)")
        let parameters : [String:String] = [
            
            "userTokenNo": authToken,
            "userName": dataJson["data"]["username"].stringValue,
            "full_name": dataJson["data"]["full_name"].stringValue,
            "followers": String(followers),
            "image_url": dataJson["data"]["profile_picture"].stringValue,
            "followedBy": dataJson["data"]["counts"]["follows"].stringValue,
            "media": dataJson["data"]["counts"]["media"].stringValue,
            "player_id": "",
            "user_category_type": "mini",
            "refer_code": code,
            
            "sector1": choice1,
            "sector2": choice2,
            "category": category,
            "city": city,
            "country": country,
            "address": address,
            "email": mailText.text!
            
        ]
        print("uRL=\(url)")
        api.alamofireApiWithParams(url: url, parameters: parameters){
            json in
            
            print("Statusagt=\(json["Status"])")
            
            //                            let pageid = flowerJSON["member_id"].stringValue
            
            
            //purpledimes.com/OrderA07Collabrub/WebServices/insert_partner_refrence_code.php?partner_id=63
            
            print("\(json)")
            
            self.user_id = json["id"].stringValue
            
            let url3 = "\(self.base_url.weburl)/insert_user_refrence_code.php"
            
                    let params3 : [String:String] = [
            
            
                        "user_id": self.user_id
            
            
                    ]
            self.api.alamofireApiWithParams(url: url3, parameters:params3){
                        json in
            
                        print("status=\(json["Status"])")
                SVProgressHUD.show(withStatus: "Loading")
                if json["Status"] == "success" {
                    SVProgressHUD.dismiss()
                            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
                     let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserInformation", into: context) as NSManagedObject
                    
                    newUser.setValue(self.dataJson["data"]["username"].stringValue, forKey: "username")
                    newUser.setValue(self.dataJson["data"]["full_name"].stringValue, forKey: "full_name")
                    newUser.setValue(self.dataJson["data"]["profile_picture"].stringValue, forKey: "profile_picture")
                    newUser.setValue(Int64(self.followers), forKey: "followers")
                    newUser.setValue(Int64(self.dataJson["data"]["counts"]["follows"].intValue), forKey: "follows")
                    newUser.setValue(self.user_id, forKey: "user_id")
                    newUser.setValue(self.authToken, forKey: "userTokenNo")
                    do {
                        try context.save()
                    } catch {}
                    
                    print(newUser)
                    print("Object Saved.")
                    
                    Defaults.setLoginStatus(logInStatus: true)
                    let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "mainTabController") as! mainTabController
                    print ("heheheh")
                    mainTabController.selectedViewController = mainTabController.viewControllers?[0]
                    self.present(mainTabController, animated: true, completion: nil)
                    
                    
                    
                }
            
                    }
            
           
            // self.present(choiceSelectionViewController, animated: true, completion: nil)
        }

//        let url2 = "\(base_url.weburl)/insert_user_invitation_code.php"
//
//        let params2 : [String:String] = [
//
//
//            "id": user_id,
//            "refer_code": code
//
//            ]
//        api.alamofireApiWithParams(url: url2, parameters:params2 ){
//             json in
//
//            print("status=\(json["Status"])")
//
//
//        }
//
//
//
//
//        let url3 = "\(base_url.weburl)/insert_user_refrence_code.php"
//
//        let params3 : [String:String] = [
//
//
//            "user_id": user_id
//
//
//        ]
//        api.alamofireApiWithParams(url: url3, parameters:params3){
//            json in
//
//            print("status=\(json["Status"])")
//
//
//        }
        
        
       
    }
    
    let GoogleMapsAPIServerKey = "AIzaSyCp93QINHvSoa0pdd1jK-oOsCZsZjAeQVI"
    
    lazy var placesSearchController: GooglePlacesSearchController = {
        let controller = GooglePlacesSearchController(delegate: self,
                                                      apiKey: GoogleMapsAPIServerKey,
                                                      placeType: .all
            
        )
        
        return controller
    }()

}

extension ChoiceSelectionViewController: GooglePlacesAutocompleteViewControllerDelegate {
    func viewController(didAutocompleteWith place: PlaceDetails) {
        print("place.description=\(place.description)")
        var lat:String = "\((place.coordinate?.latitude)!)"
        var long:String = "\((place.coordinate?.longitude)!)"
        print("lat=\(lat), long=\(long) sub :: \(place)")
        
        locationText.text = place.name
        self.country = place.country!
        if place.subLocality != nil {
            self.city = place.subLocality!
        }
        
        self.address = place.name!
//        print("country=\(place.country)")
//        print("city=\(place.locality)")
        placesSearchController.isActive = false
    }
    
    
}
