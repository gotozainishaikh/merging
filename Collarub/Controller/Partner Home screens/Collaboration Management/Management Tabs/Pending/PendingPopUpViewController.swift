//
//  PendingPopUpViewController.swift
//  Collarub
//
//  Created by mac on 13/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import CoreData
import SVProgressHUD
import TTGSnackbar

class PendingPopUpViewController: UIViewController {


    var model = FindInfluencerModel()
   
    @IBOutlet weak var usrImg: UIImageView!
    @IBOutlet weak var usrName: UILabel!
    @IBOutlet weak var address: UITextView!
    
    var url = FixVariable()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(model.user_id)

        showAnimate()
    }
    

    func setData(){
        usrImg.sd_setImage(with: URL(string: model.usrImg))
        usrName.text = model.usrname
        address.text = model.userAddress
        
    }
    func showAnimate()
    {
        setData()
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    @IBAction func cancel(_ sender: UIButton) {
        view.removeFromSuperview()
    }
    @IBAction func productSentBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Are you you have sent product", preferredStyle: .alert
        )
        
        let ok = UIAlertAction(title: "Yes", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
          
            print("Sent")
            let parameters : [String:String] = [
                
                "user_id": self.model.user_id,
                "campaign_id" : self.model.collaboration_id
                
            ]
            
            Alamofire.request("\(self.url.weburl)/update_product_sent_status.php", method: .get, parameters: parameters).responseJSON { (response) in
                SVProgressHUD.show(withStatus: "Connecting to server")
                if response.result.isSuccess {
                    
                    
                    
                    
                    let dataJSON : JSON = JSON(response.result.value!)
                    
                    if dataJSON["Status"].stringValue == "success" {
                        SVProgressHUD.dismiss()
                        
                        let snackbar = TTGSnackbar(message: "Product Sent", duration: .short)
                        snackbar.show()
                      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil, userInfo: nil)
                        self.view.removeFromSuperview()
                        
                    }
                    
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (cancel) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
     present(alert, animated: true, completion: nil)
    }
    
}
