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
    
    @IBAction func editAdd(_ sender: Any) {
        
        var textField = UITextField()

        
        let alert = UIAlertController(title: "Change Address", message: "Enter your new address", preferredStyle: .alert)
        
        let save = UIAlertAction(title: "Upadate", style: .default) { (update) in
            
            var txt = textField.text!
            if txt == "" {
                let alert1 = UIAlertController(title: "Error", message: "Please Enter Address", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: { (ok) in
                    
                    alert1.dismiss(animated: true, completion: nil)
                    self.present(alert, animated: true, completion: nil)
                })
            alert1.addAction(ok)
                
                self.present(alert1, animated: true, completion: nil)
            }
            else {
                let url = "\(self.base_url.weburl)/updateAddress.php"
                
                UserCoreData.fetchCoreData()
                let user_id = UserCoreData.user_id
                
                self.api.alamofireApiWithParams(url: url, parameters: ["user_id":user_id,"address":txt]){
                    
                    json in
                    
                    if json["Status"] == "success" {
                        print("Done")
                    }
                    
                }
                print("Address")
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (cancel) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Address"
            textField = alertTextField
            
        }
        present(alert, animated: true, completion: nil)
        
    }
    
}
