//
//  PakagePopUPViewController.swift
//  Collarub
//
//  Created by Mac 1 on 11/9/1397 AP.
//  Copyright © 1397 Mac 1. All rights reserved.
//

import UIKit
import TTGSnackbar
import Alamofire
import SwiftyJSON
import CoreData
class PakagePopUPViewController: UIViewController {

    let story = UIStoryboard(name: "User", bundle: nil)
    var user_id:String = ""
    var campaign_id:String = ""
    let url = FixVariable()
    
    @IBOutlet weak var basic: UIView!
    @IBOutlet weak var gold: UIView!
    @IBOutlet weak var free: UIButton!
    
    @IBAction func free_btn(_ sender: UIButton) {
        print("free btn")
        
        UIView.animate(withDuration: 1, animations: {
            //self.basic.backgroundColor = .brown
            self.basic.frame.origin.y -= 10
            self.free.frame.origin.y += 10
            self.basic.layer.borderWidth = 3
            self.basic.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            self.basic.frame.size.height += 20
        })
        
        free.isEnabled = false
        
    }
    
    
    @IBAction func gold_btn(_ sender: UIButton) {
        
        print("gold btn")
    }
    @IBAction func cont(_ sender: UIButton) {
        
        print("user_id\(user_id)")
        print("campaign_id\(campaign_id)")
        
        
        let vc = story.instantiateViewController(withIdentifier: "mainTabController")
        
        var message = "hello"
        let parameters : [String:String] = [
            "user_id": user_id,
            "campaign_id": campaign_id
            
        ]
        //https://purpledimes.com/OrderA07Collabrub/WebServices/user_request.php?campaign_id=1&user_id=40
        Alamofire.request("\(self.url.weburl)/user_request.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let dataJSON : JSON = JSON(response.result.value!)
                //dataJSON["data"]["counts"]["followed_by"].intValue
                message = dataJSON["Status"].stringValue
                
                
            }
            else {
                print("server down")
            }
            
            self.present(vc, animated: true){
                
                let snackbar = TTGSnackbar(message: message, duration: .short)
                snackbar.show()
            }
        }
        
        
        //        self.addChild(vc)
        //        self.view.addSubview(vc.view)
        //        vc.didMove(toParent: self)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCoreData()
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
    
    func fetchCoreData(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
        
        //var emp_details: [String] = []
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                self.user_id = data.value(forKey: "user_id") as! String
                print("user=\( self.user_id)")
            }
        }
        catch {
            
            print("Failed")
        }
    }
}
