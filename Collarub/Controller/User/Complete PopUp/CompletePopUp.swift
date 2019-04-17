//
//  CompletePopUp.swift
//  Collarub
//
//  Created by apple on 06/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Cosmos
import CoreData
import TTGSnackbar

class CompletePopUp: UIViewController {
    
    
    //Api Status
    var status:String = ""
    //parameters
    var campaign_id:String = ""
    var user_id:String = ""
    var rate:String = ""
    var review:String = ""
    var urls:String = ""
    
    //api
    var rate_partner_api:String = "rate_partner.php"
   
    //Alamofire
    let api_call = AlamofireApi()
    
    //Base Url
    let base_url = FixVariable()
    
    //user StotyBoard
    let story = UIStoryboard(name: "User", bundle: nil)
    
    //Oulets
    @IBOutlet weak var urls_view: UITextField!
    
    @IBOutlet weak var reviews_view: UITextView!
    
    @IBOutlet weak var rating: CosmosView!
    
    
    //Actions
    @IBAction func done_btn(_ sender: UIButton) {
    
        
        if(urls_view.hasText && reviews_view.hasText){
            
            
            self.rate = String(rating.rating)
            self.urls = urls_view.text!
            self.review = reviews_view.text!
            
            print("campaign_idabc=\(self.campaign_id)")
            print("user_idabc=\(self.user_id)")
            print("rateabc=\(self.rate)")
            print("urlsabc=\(self.urls)")
            print("reviewabc=\(self.review)")
            
            rate_partner(campaign_id: self.campaign_id, user_id: self.user_id, rate: self.rate, review: self.review, urls: self.urls){
                
                
                let snackbar = TTGSnackbar(message: self.status, duration: .short)
                snackbar.show()
        
                let vc = self.story.instantiateViewController(withIdentifier: "mainTabController")
                self.present(vc, animated: true, completion: nil)
            }
            
            
        }
        //let vc = story.instantiateViewController(withIdentifier: "mainTabController")
        //self.present(vc, animated: true, completion: nil)
    
//        self.view.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        user_id=get_user_id()
        
        self.reviews_view.layer.borderColor = UIColor.lightGray.cgColor
        self.reviews_view.layer.borderWidth = 1
        self.reviews_view.layer.cornerRadius = 5
       
        // Do any additional setup after loading the view.
    }
    
    

    func rate_partner(campaign_id:String, user_id:String, rate:String, review:String, urls:String, completion: @escaping () -> Void){
       
        let parameters : [String:String] = [
            "campaign_id": campaign_id,
            "user_id": user_id,
            "rate": rate,
            "review": review,
            "urls": urls
        ]
        
        var url = "\(base_url.weburl)/\(rate_partner_api)"
        print("urlxyx=\(url)")
        api_call.alamofireApiWithParams(url: url, parameters: parameters){
            
            json in
            
            self.status = json["Status"].stringValue
            print("JSONStatus=\(json["Status"].stringValue)")
            print("JSONXYZ=\(json)")
            
            completion()
        }
        
    }

    func get_user_id()->String{
    
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
    
        let results : NSArray = try! context.fetch(request) as NSArray
    
        let res = results[0] as! NSManagedObject
    
        var id : String = res.value(forKey: "user_id") as! String
    
        return id
    }
}
