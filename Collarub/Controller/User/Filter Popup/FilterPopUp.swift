//
//  FilterPopUp.swift
//  Collarub
//
//  Created by apple on 06/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//


import UIKit
import TTGSnackbar
import Alamofire
import SwiftyJSON
import CoreData
import iOSDropDown

class FilterPopUp: UIViewController {
    
    let stroy = UIStoryboard(name: "User", bundle: nil)
    var user_id:String = ""
    var campaign_id:String = ""
   
    @IBOutlet weak var cat_drop: DropDown!
    
    
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var switch4: UISwitch!
    
    @IBOutlet weak var apply_btn: UIButton!
    
    var cat_select:String = ""
    var end_soon: String = "0"
    var new: String = "0"
    var min_follower: String = "0"
    var acp_bgt : String = "0"
    
    var filter = ""

    
    
    @IBAction func apply_btn(_ sender: UIButton) {
       
//        let vc = stroy.instantiateViewController(withIdentifier: "mainTabController")
//        self.present(vc, animated: true, completion: nil)
        self.view.removeFromSuperview()
        
        if switch1.isOn {
          end_soon = "1"
            filter = "ending_soon"
        }
        if switch2.isOn {
            new = "1"
            filter = "newest"
        }
        if switch3.isOn {
            min_follower = "1"
            filter = "min_followers"
        }
        if switch4.isOn {
            acp_bgt = "1"
            filter = "except_budget"
        }
     
        
        print("cat_select=\(cat_select)")
        print("end_soon=\(end_soon)")
        print("new=\(new)")
        print("min_follower=\(min_follower)")
        print("acp_bgt=\(acp_bgt)")
       
        //var filter_dict = ["end_soon": end_soon,"new": new,"min_follower": min_follower,"acp_bgt": acp_bgt,]
        let filter_dict = ["filter": filter, "category":cat_select]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filters"), object: nil, userInfo: filter_dict)
        
//        var message = "hello"
//        let parameters : [String:String] = [
//            "user_id": end_soon,
//            "campaign_id": new,
//            "user_id": user_id,
//            "campaign_id": campaign_id,
//            "user_id": min_follower,
//            "campaign_id": acp_bgt
//
//        ]
//        Alamofire.request("https://purpledimes.com/OrderA07Collabrub/WebServices/user_request.php", method: .get, parameters: parameters).responseJSON { (response) in
//
//            if response.result.isSuccess {
//
//                let dataJSON : JSON = JSON(response.result.value!)
//                //dataJSON["data"]["counts"]["followed_by"].intValue
//                message = dataJSON["Status"].stringValue
//
//
//            }
//            else {
//                print("server down")
//            }
//
//            //self.present(vc, animated: true){
//
////                let snackbar = TTGSnackbar(message: message, duration: .short)
////                snackbar.show()
////            }
//        }
        
        
    }
    
    
    @IBAction func cancel_btn(_ sender: UIButton) {
        
        removeAnimate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.apply_btn.isEnabled = false
        //self.apply_btn.isHighlighted = false
        
        cat_drop.optionArray = ["Food","Sport","Fashion","Beauty & HelthCare","Events","Travel","Digital & Devices","Parenting","Home & Decors","Automotive","Pets"]
        cat_drop.selectedRowColor = #colorLiteral(red: 0.2156862745, green: 0.6784313725, blue: 0.5882352941, alpha: 1)
        
        cat_drop.didSelect{(selectedText , index ,id) in
            self.cat_select = "\(selectedText)"
            self.apply_btn.isEnabled = true
            //self.apply_btn.isHighlighted = true
        }
        showAnimate()
        
    }
    
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}
