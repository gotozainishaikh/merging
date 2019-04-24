//
//  PartnerHelpViewController.swift
//  Collarub
//
//  Created by mac on 22/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire
import SwiftyJSON
import SVProgressHUD

class PartnerHelpViewController: UIViewController {

    var url = FixVariable()
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var name: UITextField!
    // @IBOutlet weak var email: UITextField!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var email: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        border(borderView: self.questionView)
        border(borderView: self.midView)
        border(borderView: self.bottomView)
        
       
    }
    

    func border(borderView : UIView){
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor(named: "themecolor4")?.cgColor
    }
    
  
    @IBAction func sendBtn(_ sender: UIButton) {
        
        var name = self.name.text!
        var email = self.email.text!
        var message = self.message.text!
        
        if (name != "" && email != "" && message != ""){
            
            
            print("\(name)")
            print("\(email)")
            print("\(message)")
            
            let parameters : [String:String] = [
                
                "name": name,
                "email" : email,
                "phone_no" : message
                
            ]
            
            Alamofire.request("\(self.url.weburl)/contact_us.php", method: .get, parameters: parameters).responseJSON { (response) in
                SVProgressHUD.show(withStatus: "Loading")
                if response.result.isSuccess {
                    SVProgressHUD.dismiss()
                    let dataJSON1 : JSON = JSON(response.result.value!)
                    
                    if dataJSON1["status"] == "Success" {
                        
                        
                        SVProgressHUD.showSuccess(withStatus: "Done")
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                }
                
            }
            
        }else {
            
            let alert = UIAlertController(title: "email", message: "fill all fields", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                alert.dismiss(animated: true, completion: nil)
                
            }
            
            alert.addAction(cancel)
            present(alert,animated: true,completion: nil)
            
        }
        
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
