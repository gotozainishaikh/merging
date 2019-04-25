//
//  UserSelectionViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 24/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import CoreData


class UserSelectionViewController: UIViewController {

    
    //var uerCoreData = UserCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func userClick(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "User", bundle: nil)
        if Defaults.isLogedIn {
            
            
            let mainTabController = storyBoard.instantiateViewController(withIdentifier: "mainTabController") as! mainTabController
            mainTabController.selectedViewController = mainTabController.viewControllers?[0]
            UserCoreData.fetchCoreData()
            self.present(mainTabController, animated: true, completion: nil)
            
            
            
        }else {
            
            let vc = storyBoard.instantiateViewController(withIdentifier: "loginWithInsta") as! UserLoginViewController
            //UserCoreData.fetchCoreData()
            present(vc, animated: true, completion: nil)
        }
        
    }
    @IBAction func businessClick(_ sender: UIButton) {
        
        if Defaults.isPartnerLogedIn {
            
            let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "partnerTab") as! PartnerTabBarController
            
            mainTabController.selectedViewController = mainTabController.viewControllers?[0]
            self.present(mainTabController, animated: true, completion: nil)
            
        }else {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "partnerInstaLogin") as! PartnerLoginButtonViewController
            present(vc, animated: true, completion: nil)
            
        }
        
        
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
