//
//  CompnayDetailsViewController.swift
//  Collarub
//
//  Created by mac on 19/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import SwiftyJSON

class CompnayDetailsViewController: UIViewController {

    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var zipCode: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var vatNum: UILabel!
    @IBOutlet weak var invoiceNum: UILabel!
    
    var json : JSON!
    override func viewDidLoad() {
        super.viewDidLoad()

        companyName.text = json["companyNme"].stringValue
        address.text = json["address"].stringValue
        city.text = json["city"].stringValue
         zipCode.text = json["zipCode"].stringValue
        country.text = json["vatNumber"].stringValue
        vatNum.text = json["country"].stringValue
        invoiceNum.text = json["invoiceEmail"].stringValue
       
        
    }
    

    @IBAction func cancl(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
