//
//  UserPlan.swift
//  Collarub
//
//  Created by apple on 10/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class UserPlan: UIViewController {

    //Alamofire
    let api = AlamofireApi()
    
    //Base URl
    var base_url = FixVariable()
    
    
    var user_type:String = "0"
    @IBOutlet weak var plan: UILabel!
    
    @IBOutlet weak var plan_type: UILabel!
    @IBOutlet weak var plan_btn: UIButton!
    
    @IBOutlet weak var plan_view: UIView!
    
    @IBOutlet weak var card: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.plan_btn.isHidden = true
        
        self.plan_view.isHidden = true
        
        showAnimate()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        self.view.addGestureRecognizer(tap)
        
        self.view.isUserInteractionEnabled = true
        
        
        check_user{
            
            //print
            print("user-type=\( self.user_type)")
            if(self.user_type=="1"){
                self.plan.text = "Fremium"
                self.plan_btn.setTitle("FREE", for: .normal)
                self.plan_type.text = "2 Collaborations per month"
            }
            else if(self.user_type=="2"){
                self.plan.text = "1 Month"
                self.plan_btn.setTitle("GOLD", for: .normal)
                self.plan_btn.backgroundColor =  UIColor.init(named: "light-gold")
                self.plan_type.text = "Unlimited Collaborations for 1 month"
                self.plan_view.backgroundColor = UIColor.init(named: "dark-gold")
                self.card.backgroundColor = UIColor.init(named: "dark-gold")
                
            }
            else if(self.user_type=="3"){
                self.plan.text = "6 Month"
                self.plan_btn.setTitle("GOLD", for: .normal)
                self.plan_btn.backgroundColor =  UIColor.init(named: "light-gold")
                self.plan_type.text = "Unlimited Collaborations for 6 month"
                self.plan_view.backgroundColor = UIColor.init(named: "dark-gold")
                self.card.backgroundColor = UIColor.init(named: "dark-gold")
            }
            else if(self.user_type=="4"){
                self.plan.text = "1 Year"
                self.plan_btn.setTitle("GOLD", for: .normal)
                self.plan_btn.backgroundColor =  UIColor.init(named: "light-gold")
                self.plan_type.text = "Unlimited Collaborations for 1 Year"
                self.plan_view.backgroundColor = UIColor.init(named: "dark-gold")
                self.card.backgroundColor = UIColor.init(named: "dark-gold")
            }
            
            self.plan_btn.isHidden = false
            
            self.plan_view.isHidden = false
            
        }
        
      
       
        // Do any additional setup after loading the view.
    }
    
    
    
    func check_user(completion: @escaping () -> Void){
        
        let url = "\(base_url.weburl)/checkUser.php"
        let uName = UserCoreData.username
        print("uName=\(uName)")
        api.alamofireApiWithParams(url: url, parameters: ["user_username":uName]){
            
            json in
            
            
            print("check_id=\(json["userrType"])")
            if(json["id"] != ""){
                
                self.user_type = json["userrType"].stringValue
            }
            
            
            completion()
            
        }
        
    }
    
    @IBOutlet weak var outside: UIView!
    
   
    
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        removeAnimate()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
