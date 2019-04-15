//
//  SettingPopUpViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 19/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class SettingPopUpViewController: UIViewController {

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

    @IBAction func cancelBtn(_ sender: UIButton) {
        
        removeAnimate()
    }
}
