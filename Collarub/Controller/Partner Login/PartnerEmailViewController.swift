//
//  PartnerEmailViewController.swift
//  Collarub
//
//  Created by mac on 22/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData
import KWVerificationCodeView
import SVProgressHUD

class PartnerEmailViewController: UIViewController {

    var dataJson : JSON!
    var followers : Int!
    var authToken : String!
    var user_id : String!
    var api = AlamofireApi()
    var url = FixVariable()
    
    @IBOutlet weak var verificationCode: KWVerificationCodeView!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if emailField.text?.isEmpty == true {
            let empAlert = UIAlertController(title: "Warning", message: "Please Enter Email", preferredStyle: .alert)
            
            
            
            let okay = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                
                
                empAlert.dismiss(animated: true, completion: nil)
                
                
                
            })
            empAlert.addAction(okay)
            present(empAlert, animated: true, completion: nil)
        }else if emailTest.evaluate(with: emailField.text) == false {
            let empAlert = UIAlertController(title: "Warning", message: "Please Enter correct Email", preferredStyle: .alert)
            
            
            
            let okay = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                
                empAlert.dismiss(animated: true, completion: nil)
                
              
                
            })
            empAlert.addAction(okay)
            present(empAlert, animated: true, completion: nil)
        }else {
            
            print("codee :: \(verificationCode.getVerificationCode())")
            
            var code : String = ""
            if verificationCode.hasValidCode() {
                 code = verificationCode.getVerificationCode()
            }
            
            let param : [String:String] = [
                
                "user_token": authToken,
                
                "partner_username" : dataJson["data"]["username"].stringValue,
                
                "partner_name" : dataJson["data"]["full_name"].stringValue,
                
                "followers" : String(followers),
                
                "partner_img" : dataJson["data"]["profile_picture"].stringValue,
                
                "followed_by" : dataJson["data"]["counts"]["follows"].stringValue,
                
                "partner_email" : emailField.text!,
                
                "media" : dataJson["data"]["counts"]["media"].stringValue,
                
                "player_id" : "",
                
                "refer_code":code
                
                
                
                
            ]
            
            Alamofire.request("\(url.weburl)/PartnerRegister.php", method: .get, parameters: param).responseJSON { response in
                
                
                if response.result.isSuccess {
                    
                    //  print("Response JSON: \(JSON(response.result.value!))")
                    
                    
                    
                    let flowerJSON : JSON = JSON(response.result.value!)
                    
                    //                            let pageid = flowerJSON["member_id"].stringValue
                    
                    
                    //purpledimes.com/OrderA07Collabrub/WebServices/insert_partner_refrence_code.php?partner_id=63
                    
                    print("\(flowerJSON)")
                    
                    self.user_id = flowerJSON["id"].stringValue
                    
                    print(flowerJSON["id"].stringValue)
                    
                    self.api.alamofireApiWithParams(url: "\(self.url.weburl)/insert_partner_refrence_code.php", parameters: ["partner_id":self.user_id], completion: { (json) in
                        
                        SVProgressHUD.show(withStatus: "Loading")
                        if json["Status"] == "success" {
                            SVProgressHUD.dismiss()
                            // success
                            
                            
                            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                            
                            
                            
                            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
                            
                            
                            
                            let newUser = NSEntityDescription.insertNewObject(forEntityName: "PartnerRegistration", into: context) as NSManagedObject
                            
                            newUser.setValue(self.dataJson["data"]["username"].stringValue, forKey: "userName")
                            
                            newUser.setValue(self.dataJson["data"]["full_name"].stringValue, forKey: "full_name")
                            
                            newUser.setValue(self.dataJson["data"]["profile_picture"].stringValue, forKey: "profile_picture")
                            
                            newUser.setValue(Int64(self.followers), forKey: "followers")
                            
                            newUser.setValue(Int64(self.dataJson["data"]["counts"]["follows"].intValue), forKey: "follows")
                            
                            newUser.setValue(flowerJSON["id"].stringValue, forKey: "user_id")
                            
                            newUser.setValue(self.emailField.text!, forKey: "email")
                            
                            do {
                                
                                try context.save()
                                
                            } catch {}
                            
                            
                            
                            print(newUser)
                            
                            print("Object Saved.")
                            
                            // print(flowerJSON["id"])
                            
                            
                            
                            Defaults.setPartnerLoginStatus(logInStatus: true)
                            
                            let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "stepController") as! StepViewController
                            
                            
                            
                            //                                            mainTabController.selectedViewController = mainTabController.viewControllers?[0]
                            
                            self.present(mainTabController, animated: true, completion: nil)
                            
                            
                            //end success
                        }
                        else if json["Status"] == "failed" {
                        
                            SVProgressHUD.show(withStatus: "Server Error")
                        }
                    })
                    
                }else {
                    
                    print("Error in register server")
                    
                }
                
            }
            
        }
    }
   
    
   
    

}
