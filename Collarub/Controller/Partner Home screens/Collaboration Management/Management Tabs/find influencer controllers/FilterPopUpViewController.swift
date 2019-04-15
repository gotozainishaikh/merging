//
//  FilterPopUpViewController.swift
//  Collarub
//
//  Created by mac on 09/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class FilterPopUpViewController: UIViewController {

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
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
