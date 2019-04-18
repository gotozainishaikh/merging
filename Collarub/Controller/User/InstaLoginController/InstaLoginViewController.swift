//
//  InstaLoginViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 24/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData


class InstaLoginViewController: UIViewController, UIWebViewDelegate {

    
    
    //Alamofire
    let api = AlamofireApi()
    
    //Base URl
    var base_url = FixVariable()
    
    //User First Login
    var first_time:String = "0"
    
   // var instaData : [InstagramUserData] = [InstagramUserData]()
    static let model : InstagramUserData = InstagramUserData()
    var user_id : String = ""
    @IBOutlet weak var loginWebView: UIWebView!
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            check_user {
                self.handleAuth(authToken: requestURLString.substring(from: range.upperBound))
            }
            
            
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
                if followers > -1 {
//                    ChoiceSelectionViewController
                    
                    
                    print("firstTime=\(self.first_time)")
                    
                    if(self.first_time=="1"){
                        let choiceSelectionViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChoiceSelectionViewController") as! ChoiceSelectionViewController
                        print ("heheheh")
                     
                        self.present(choiceSelectionViewController, animated: true, completion: nil)
                    }
                    else{
                        let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "mainTabController") as! mainTabController
                        print ("heheheh")
                        mainTabController.selectedViewController = mainTabController.viewControllers?[0]
                        self.present(mainTabController, animated: true, completion: nil)
                    }
                    Defaults.setLoginStatus(logInStatus: true)
                    // data model
                    
                    let param : [String:String] = [
                        "access_token": authToken,
                        "userName" : dataJSON["data"]["username"].stringValue,
                        "full_name" : dataJSON["data"]["full_name"].stringValue,
                        "followers" : String(followers),
                        "image_url" : dataJSON["data"]["profile_picture"].stringValue,
                        "followedBy" : dataJSON["data"]["counts"]["follows"].stringValue
                        
                    ]
                    
                   
                    
                    Alamofire.request("https://purpledimes.com/OrderA07Collabrub/WebServices/User_Registration.php", method: .get, parameters: param).responseJSON { response in
                        
                        if response.result.isSuccess {
                          //  print("Response JSON: \(JSON(response.result.value!))")
                            
                            let flowerJSON : JSON = JSON(response.result.value!)
                            //                            let pageid = flowerJSON["member_id"].stringValue
                            
                            self.user_id = flowerJSON["id"].stringValue
                            
                            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                            
                            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
                            
                            let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserInformation", into: context) as NSManagedObject
                            newUser.setValue(dataJSON["data"]["username"].stringValue, forKey: "username")
                            newUser.setValue(dataJSON["data"]["full_name"].stringValue, forKey: "full_name")
                            newUser.setValue(dataJSON["data"]["profile_picture"].stringValue, forKey: "profile_picture")
                            newUser.setValue(Int64(followers), forKey: "followers")
                            newUser.setValue(Int64(dataJSON["data"]["counts"]["follows"].intValue), forKey: "follows")
                            newUser.setValue(flowerJSON["id"].stringValue, forKey: "user_id")
                            
                            do {
                                try context.save()
                            } catch {}
                            
                            print(newUser)
                            print("Object Saved.")
                           // print(flowerJSON["id"])
                            
                            
                        }
                    }
                    
                    
                    
                  //  print("\(flowerJSON["id"])")

                    
                }else {
                    let alert = UIAlertController(title: "You have insufficient Users", message: "The minimum amount of users should be 500", preferredStyle: .alert)
                    
                    let reStart = UIAlertAction(title: "OK", style: .default, handler:
                    { (UIAlertAction) in
                        
                        self.dismiss(animated: true, completion: nil)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainScreen") as! UserSelectionViewController
                        self.present(vc, animated: true, completion: nil)
                        
                    })
                    
                    alert.addAction(reStart)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }else {
                print("error not get")
            }
            }.resume()
        
        
    }
    
    func check_user(completion: @escaping () -> Void){
      
        let url = "\(base_url.weburl)/checkUser.php"
        
        api.alamofireApiWithParams(url: url, parameters: ["user_username":"talha1895"]){
            
            json in
            
            
            print("check_id=\(json["id"])")
            if(json["id"] == ""){
                
                self.first_time = "1"
            }
            else{
                self.first_time = "0"
            }
            
            completion()
            
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
