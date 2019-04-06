//
//  customTabViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 05/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class customTabViewController: UITabBarController {

    @IBOutlet weak var finabcialTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.finabcialTabBar.frame = CGRect( x: 0, y: 0, width: 320, height: 50)  //example for iPhone 5

        
    }
    

    

}
