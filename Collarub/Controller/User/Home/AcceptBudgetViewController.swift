//
//  AcceptBudgetViewController.swift
//  Collarub
//
//  Created by mac on 15/05/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import SVProgressHUD

class AcceptBudgetViewController: UIViewController {

    @IBOutlet weak var budget_field: UITextField!
    
    var val : String!
     let api = AlamofireApi()
    
    //base Url
    let base_url = FixVariable()
    
    //User_id
    var user_id : String!
    
    var col_id : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showAnimate()
        print(val!)
        
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
    
    
    @IBAction func cancel(_ sender: Any) {
       removeAnimate()
    }
    
    @IBAction func accpt_btn(_ sender: UIButton) {
        

        if budget_field.text! == "" {
            let alert1 = UIAlertController(title: "Warning", message: "Please insert budget for negotiation", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default) { (ok) in
                alert1.dismiss(animated: true, completion: nil)
                
            }
            alert1.addAction(ok)
            present(alert1, animated: true, completion: nil)
            
        } else {
            var int : Int = Int(budget_field.text!)!
            if (int > Int(val)!) {
            
            let alert1 = UIAlertController(title: "Warning", message: "Your budget exceed", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default) { (ok) in
                alert1.dismiss(animated: true, completion: nil)
                
            }
            alert1.addAction(ok)
            present(alert1, animated: true, completion: nil)
            
        }
        else {
            print("budget val :: \(budget_field.text!)")
                api.alamofireApiWithParams(url: "\(self.base_url.weburl)/insert_negotiation.php", parameters: ["user_id":user_id,"col_id":col_id,"budget_val":budget_field.text!]) { (json) in
                    SVProgressHUD.show()
                    if json["Status"] == "success" {
                        print("success")
                        SVProgressHUD.showSuccess(withStatus: "Budget Sent")
                        self.removeAnimate()
                    }
                    
                }
                
        }
        
    }
    }
}
