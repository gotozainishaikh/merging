//
//  SettingPopUpViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 19/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import TTGSnackbar
import CoreData

class SettingPopUpViewController: UIViewController {

    
    let story = UIStoryboard(name: "User", bundle: nil)
    
    let api = AlamofireApi()
    let base_url = FixVariable()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    
    @IBAction func payment_method_btn(_ sender: UIButton) {
        
                let vc = story.instantiateViewController(withIdentifier: "UpgradePopUP")
        
                self.addChild(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
    }
    
    @IBAction func address_btn(_ sender: UIButton) {
        
        let vc = story.instantiateViewController(withIdentifier: "AddressPopUp")
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    @IBAction func push_not_btn(_ sender: Any) {
    
        let vc = story.instantiateViewController(withIdentifier: "PushNotificationPopUp")
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    
    }
    
    
    @IBAction func delete_account(_ sender: UIButton) {
        
        
        
        // create the alert
        let alert = UIAlertController(title: "Delete Account", message: "Are You Sure?", preferredStyle: UIAlertController.Style.alert)
        
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
            
            // do something like...
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { action in
            
            // do something like...
            
            let url = "\(self.base_url.weburl)/delete_account.php"
            
            UserCoreData.fetchCoreData()
            print("UserCoreData.username=\(UserCoreData.username)")
            let params = [
                
                "userName" : UserCoreData.username
            ]
            
            self.api.alamofireApiWithParams(url: url, parameters: params){
                
                json in
                
                print("Status=\(json["Status"])")
                
                
                
                
                if let cookies = HTTPCookieStorage.shared.cookies {
                    for cookie in cookies {
                        if cookie.domain.contains(".instagram.com") {
                            HTTPCookieStorage.shared.deleteCookie(cookie)
                        }
                    }
                    
                    Defaults.setLoginStatus(logInStatus: false)
                    
                    let storyMain = UIStoryboard(name: "Main", bundle: nil)
                    
                    let vc = storyMain.instantiateViewController(withIdentifier: "mainScreen")
                    self.present(vc, animated: true){
                        
                        let snackbar = TTGSnackbar(message: json["Status"].stringValue, duration: .short)
                        snackbar.show()
                    }
                    
                    self.deleteAllRecords()
                    
                }
                
            }
                
            
            
            
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
       
    }
    
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        
        removeAnimate()
    }
}
