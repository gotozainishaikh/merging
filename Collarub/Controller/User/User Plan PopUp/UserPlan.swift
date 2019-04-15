//
//  UserPlan.swift
//  Collarub
//
//  Created by apple on 10/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class UserPlan: UIViewController {

    var user_type:String = "3"
    @IBOutlet weak var plan: UILabel!
    
    @IBOutlet weak var plan_type: UILabel!
    @IBOutlet weak var plan_btn: UIButton!
    
    @IBOutlet weak var plan_view: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showAnimate()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        self.view.addGestureRecognizer(tap)
        
        self.view.isUserInteractionEnabled = true
        
      
        if(user_type=="1"){
            plan.text = "Fremium"
            plan_btn.setTitle("FREE", for: .normal)
            plan_type.text = "2 Collaborations per month"
        }
        else if(user_type=="2"){
            plan.text = "1 Month"
            plan_btn.setTitle("GOLD", for: .normal)
            plan_btn.backgroundColor =  UIColor.init(named: "light-gold")
            plan_type.text = "Unlimited Collaborations for 1 month"
            plan_view.backgroundColor = UIColor.init(named: "dark-gold")
        }
        else if(user_type=="3"){
            plan.text = "6 Month"
            plan_btn.setTitle("GOLD", for: .normal)
            plan_btn.backgroundColor =  UIColor.init(named: "light-gold")
            plan_type.text = "Unlimited Collaborations for 6 month"
            plan_view.backgroundColor = UIColor.init(named: "dark-gold")
        }
        else if(user_type=="4"){
            plan.text = "1 Year"
            plan_btn.setTitle("GOLD", for: .normal)
            plan_btn.backgroundColor =  UIColor.init(named: "light-gold")
            plan_type.text = "Unlimited Collaborations for 1 Year"
            plan_view.backgroundColor = UIColor.init(named: "dark-gold")
        }
        // Do any additional setup after loading the view.
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
