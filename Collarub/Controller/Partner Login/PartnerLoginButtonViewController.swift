//
//  PartnerLoginButtonViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 12/02/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class PartnerLoginButtonViewController: UIViewController {

    
    @IBOutlet weak var loginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.loginView.layer.borderWidth = 1
        self.loginView.layer.borderColor = UIColor.white.cgColor
        
       
    }
    
    @IBAction func backBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "mainScreen")
        present(vc!, animated: true, completion: nil)
    }
    
}
