//
//  CompletePopUp.swift
//  Collarub
//
//  Created by apple on 06/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Cosmos

class CompletePopUp: UIViewController {
    
    let story = UIStoryboard(name: "User", bundle: nil)
    @IBOutlet weak var rating: CosmosView!
    
    @IBAction func done_btn(_ sender: UIButton) {
    
        
        let vc = story.instantiateViewController(withIdentifier: "mainTabController")
        self.present(vc, animated: true, completion: nil)
    
//        self.view.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
