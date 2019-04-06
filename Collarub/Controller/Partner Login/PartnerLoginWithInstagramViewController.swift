//
//  PartnerLoginWithInstagramViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 05/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class PartnerLoginWithInstagramViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var loginWebView: UIWebView!
    var user_id : String = ""
    var email : String = ""
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                if cookie.domain.contains(".instagram.com") {
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                }
            }
        }
        
        loginWebView.delegate = self
        unSignedRequest()
        
    }
    
    
    func unSignedRequest () {
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [INSTAGRAM_IDS.INSTAGRAM_AUTHURL,INSTAGRAM_IDS.INSTAGRAM_CLIENT_ID,INSTAGRAM_IDS.INSTAGRAM_REDIRECT_URI, INSTAGRAM_IDS.INSTAGRAM_SCOPE ])
        let urlRequest =  URLRequest.init(url: URL.init(string: authURL)!)
        print(authURL)
        loginWebView.loadRequest(urlRequest)
        
        //        let story = UIStoryboard(name: "Main", bundle: nil)
        //        present(story.instantiateViewController(withIdentifier: "open"), animated: true, completion: nil)
        //
        
    }
    
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        
        let requestURLString = (request.url?.absoluteString)! as String
        
        if requestURLString.hasPrefix(INSTAGRAM_IDS.INSTAGRAM_REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            handleAuth(authToken: requestURLString.substring(from: range.upperBound))
            
            //            let story = UIStoryboard(name: "Main", bundle: nil)
            //            present(story.instantiateViewController(withIdentifier: "open"), animated: true, completion: nil)
            return false;
        }
        return true
    }
    
    
    func handleAuth(authToken: String)  {
        print("Instagram authentication token ==", authToken)
        
        let url = String(format: "https://api.instagram.com/v1/users/self/?access_token=%@", authToken)
        let request : NSMutableURLRequest = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        //        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
        //
        //            if let data = data {
        //
        //                let dataJson : JSON = try! JSON(data)
        //            //    let json = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
        //
        //                let strfull = dataJson["data"]["counts"]["follows"].stringValue
        //
        //                let alert = UIAlertController(title: "Full Name", message: "\(strfull)", preferredStyle: .alert)
        //
        //                self.present(alert, animated: true, completion: nil)
        //            }
        //        }.resume()
        
        let parameters : [String:String] = [
            "access_token": authToken
            
        ]
        
        
        Alamofire.request("https://api.instagram.com/v1/users/self/?", method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let dataJSON : JSON = JSON(response.result.value!)
                let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                
                //  let alert = UIAlertController(title: "Full Name", message: "\(desp)", preferredStyle: .alert)
                
                //                    let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "mainTabController") as! mainTabController
                //                    mainTabController.selectedViewController = mainTabController.viewControllers?[0]
                //                    self.present(mainTabController, animated: true, completion: nil)
                //
                
                // data model
                
                Alamofire.request("https://purpledimes.com/OrderA07Collabrub/WebServices/checkUSer.php", method: .get, parameters: parameters).responseJSON { response in
                    
                    if response.result.isSuccess {
                        //  print("Response JSON: \(JSON(response.result.value!))")
                        
                        let flowerJSON1 : JSON = JSON(response.result.value!)
                        //                            let pageid = flowerJSON["member_id"].stringValue
                        
                        print("hello \(flowerJSON1)")
                        self.user_id = flowerJSON1["partner_id"].stringValue
                        
                        if (self.user_id == ""){
                            
                            var textfield = UITextField()
                            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                            
                            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                            let alert = UIAlertController(title: "Enter Email", message: "Please type your email", preferredStyle: .alert)
                            
                            let action = UIAlertAction(title: "Save", style: .default) { (addaction) in
                                
                                if textfield.text?.isEmpty == true || emailTest.evaluate(with: textfield.text!) == false {
                                    let empAlert = UIAlertController(title: "Warning", message: "Please Enter Correct Email", preferredStyle: .alert)
                                    
                                    let okay = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                                        empAlert.dismiss(animated: true, completion: nil)
                                        self.present(alert, animated: true, completion: nil)
                                    })
                                    
                                    print(emailTest.evaluate(with: textfield.text!))
                                    empAlert.addAction(okay)
                                    
                                    self.present(empAlert, animated: true, completion: nil)
                                }
                                
                                else {
                                    
                                    self.email = textfield.text!
                                    
                                    let param : [String:String] = [
                                        "access_token": authToken,
                                        "userName" : dataJSON["data"]["username"].stringValue,
                                        "full_name" : dataJSON["data"]["full_name"].stringValue,
                                        "followers" : String(followers),
                                        "image_url" : dataJSON["data"]["profile_picture"].stringValue,
                                        "followedBy" : dataJSON["data"]["counts"]["follows"].stringValue,
                                        "e_mail" : self.email
                                        
                                    ]
                                    Alamofire.request("https://purpledimes.com/OrderA07Collabrub/WebServices/PartnerRegister.php", method: .get, parameters: param).responseJSON { response in
                                        
                                        print(self.email)
                                        if response.result.isSuccess {
                                            //  print("Response JSON: \(JSON(response.result.value!))")
                                            
                                            let flowerJSON : JSON = JSON(response.result.value!)
                                            //                            let pageid = flowerJSON["member_id"].stringValue
                                            
                                            print("\(flowerJSON)")
                                            self.user_id = flowerJSON["id"].stringValue
                                            print(flowerJSON["id"].stringValue)
                                            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                                            
                                            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
                                            
                                            let newUser = NSEntityDescription.insertNewObject(forEntityName: "PartnerRegistration", into: context) as NSManagedObject
                                            newUser.setValue(dataJSON["data"]["username"].stringValue, forKey: "userName")
                                            newUser.setValue(dataJSON["data"]["full_name"].stringValue, forKey: "full_name")
                                            newUser.setValue(dataJSON["data"]["profile_picture"].stringValue, forKey: "profile_picture")
                                            newUser.setValue(Int64(followers), forKey: "followers")
                                            newUser.setValue(Int64(dataJSON["data"]["counts"]["follows"].intValue), forKey: "follows")
                                            newUser.setValue(flowerJSON["id"].stringValue, forKey: "user_id")
                                            newUser.setValue(self.email, forKey: "email")
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
                                        }else {
                                            print("Error in register server")
                                        }
                                    }
                                    
                                    
                                    print("\(param)")
                                    //                        let newItem = Category(context: self.context)
                                    //                        newItem.name = textfield.text
                                    //                        self.arrayItem.append(newItem)
                                    //
                                    //                        self.saveItem()
                                    
                                    
                                }
                            }
                            
                            let cancl = UIAlertAction(title: "Cancel", style: .default) { (addaction) in
                                
                                self.dismiss(animated: true, completion: nil)
                            }
                            
                            alert.addTextField { (addText) in
                                addText.placeholder = "Create new category"
                                
                                textfield = addText
                            }
                            
                            
                            alert.addAction(action)
                            alert.addAction(cancl)
                            
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                        else {
                            print(self.user_id)
                            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

                            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")

                            let newUser = NSEntityDescription.insertNewObject(forEntityName: "PartnerRegistration", into: context) as NSManagedObject
                            newUser.setValue(dataJSON["data"]["username"].stringValue, forKey: "userName")
                            newUser.setValue(dataJSON["data"]["full_name"].stringValue, forKey: "full_name")
                            newUser.setValue(dataJSON["data"]["profile_picture"].stringValue, forKey: "profile_picture")
                            newUser.setValue(Int64(followers), forKey: "followers")
                            newUser.setValue(Int64(dataJSON["data"]["counts"]["follows"].intValue), forKey: "follows")
                            newUser.setValue(self.user_id, forKey: "user_id")
                            newUser.setValue(flowerJSON1["partner_email"].stringValue, forKey: "email")
                            do {
                                try context.save()
                            } catch {}

                            print("exist user : \(newUser)")
                            print("Object Saved.")

                            Defaults.setPartnerLoginStatus(logInStatus: true)
                            let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "partnerTab") as! PartnerTabBarController

                            mainTabController.selectedViewController = mainTabController.viewControllers?[0]
                            self.present(mainTabController, animated: true, completion: nil)
                            
                        }
                        
                    }
                }
                
                
                
            }else {
                print("Error not get")
            }
        }
    }
    
    
    
    
    // MARK: - UIWebViewDelegate
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        return checkRequestForCallbackURL(request: request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loginIndicator.isHidden = false
        loginIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loginIndicator.isHidden = true
        loginIndicator.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        webViewDidFinishLoad(webView)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if (scrollView.contentOffset.y < 0){
            //reach top
            print("Reach Top")
            loginWebView.reload()
        }
    }
    
    
}
