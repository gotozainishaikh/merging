//
//  PushNotificationPopUp.swift
//  Collarub
//
//  Created by apple on 19/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import TTGSnackbar

class PushNotificationPopUp: UIViewController {

    let api = AlamofireApi()
    let base_url = FixVariable()
    

    @IBOutlet weak var `switch`: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showAnimate()
        
        UserCoreData.fetchCoreData()
        
        let url = "\(base_url.weburl)/get_user_push_status.php"
        
       
        api.alamofireApiWithParams(url: url, parameters: ["id":UserCoreData.user_id]){
            
            json in
            
            let push_status = json["push_status"].stringValue
            print("push_status=\(push_status)")
            switch push_status {
            case "1":
                 self.switch.setOn(true, animated: false)
            default:
                 self.switch.setOn(false, animated: false)
            }
            
        }
        
       
      
    }
    
    
    
    @IBAction func cancel_btn(_ sender: UIButton) {
        
        removeAnimate()
        
    }
    
    @IBAction func change_switch(_ sender: UISwitch) {
        
        self.switch.isEnabled = false
        
        print(self.switch.isOn)
        
        UserCoreData.fetchCoreData()
        
        let url = "\(base_url.weburl)/update_user_push_status.php"
        var push_status = "0"
        var msg = ""
        
        if(self.switch.isOn){
            
            push_status = "1"
            msg = "Turned On Push Notifications"
            
        }
        else{
            
            push_status = "0"
            msg = "Turned Off Push Notifications"
            
        }
        
        
        api.alamofireApiWithParams(url: url, parameters: ["id":UserCoreData.user_id,"push_status":push_status] ){
            
            json in
            
            
            
            
            let snackbar = TTGSnackbar.init(message: "\(json["Status"])! \(msg)", duration: .short)
            snackbar.show()
            
            self.switch.isEnabled = true
            
            
        }
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
