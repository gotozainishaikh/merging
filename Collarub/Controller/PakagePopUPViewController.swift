//
//  PakagePopUPViewController.swift
//  Collarub
//
//  Created by Mac 1 on 11/9/1397 AP.
//  Copyright © 1397 Mac 1. All rights reserved.
//

import UIKit

class PakagePopUPViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
}
