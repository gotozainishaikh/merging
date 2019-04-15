//
//  PendingPopUpViewController.swift
//  Collarub
//
//  Created by mac on 13/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class PendingPopUpViewController: UIViewController {

    var model = FindInfluencerModel()
    
    @IBOutlet weak var usrImg: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        print(model.user_id)
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
    @IBAction func cancel(_ sender: UIButton) {
        view.removeFromSuperview()
    }
    @IBAction func productSentBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Are you you have sent product", preferredStyle: .alert
        )
        
        let ok = UIAlertAction(title: "Yes", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (cancel) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
     present(alert, animated: true, completion: nil)
    }
    
}
