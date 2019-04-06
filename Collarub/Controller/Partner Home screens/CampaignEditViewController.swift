//
//  CampaignEditViewController.swift
//  Collarub
//
//  Created by mac on 03/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import iOSDropDown

class CampaignEditViewController: UIViewController {

    @IBOutlet weak var chooseCat: DropDown!
    override func viewDidLoad() {
        super.viewDidLoad()

        chooseCat.optionArray = ["Male", "Female"]
        chooseCat.text = "Male"
        //chooseCat.selectedIndex = 1
        chooseCat.arrowSize = 10
        chooseCat.didSelect{(selectedText , index , id) in
            print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            
            // self.selectedtex = selectedText
        }
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
