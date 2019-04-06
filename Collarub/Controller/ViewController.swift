//
//  ViewController.swift
//  Collarub
//
//  Created by Mac 1 on 10/13/1397 AP.
//  Copyright © 1397 Mac 1. All rights reserved.
//

import UIKit
import RadioButton

class ViewController: UIViewController {

    @IBOutlet weak var logoImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        

        logoImg.alpha=0.0
        
        if(logoImg.alpha==0.0)
        {
            
            // splash screen with animation here
            UIView.animate(withDuration: 2.0, delay: 1.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {self.logoImg.alpha=1.0}, completion: { (Bool) in
                print("completes")
                
                // chnaging the screen here
              self.performSegue(
                   withIdentifier:"mainScreen",sender: self)
                
            })
            
            
            
        }
    }
    
    

}

