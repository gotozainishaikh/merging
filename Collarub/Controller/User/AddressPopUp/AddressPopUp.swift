//
//  AddressPopUp.swift
//  Collarub
//
//  Created by apple on 19/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class AddressPopUp: UIViewController {

    let api =  AlamofireApi()
    let base_url = FixVariable()
    
    @IBOutlet weak var address: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        address.isHidden = true
        
        let url = "\(base_url.weburl)/get_user_address.php"
        
        UserCoreData.fetchCoreData()
        let user_id = UserCoreData.user_id
        
        api.alamofireApiWithParams(url: url, parameters: ["user_id":user_id]){
            
            json in
            
            print("address=\(json["address"].stringValue)")
            
            self.address.text = json["address"].stringValue
            
            self.address.isHidden = false
            
        }
        
        
        
        showAnimate()
        
        
        

        // Do any additional setup after loading the view.
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
    

    @IBAction func cancel_btn(_ sender: Any) {
        
        removeAnimate()
    }
    

}
