//
//  UserLoginViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 04/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class UserLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        
       self.performSegue(withIdentifier: "instaView", sender: self)
//        self.performSegue(withIdentifier: "mainTabView", sender: self)
        
//        if CheckInternet.Connection() {
//            self.performSegue(withIdentifier: "instaView", sender: self)
//        }else {
//
//            let alert = UIAlertController(title: "Alert", message: "Check Your Internet Connection", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//
//        }
        
    }
    
}
