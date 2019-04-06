//
//  PartnerManualRegisterViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 12/02/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PartnerManualRegisterViewController: UIViewController {

    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    let url = "https://purpledimes.com/OrderA07Collabrub/WebServices/imageUpload.php"
    
    let img = UIImage(named: "instaImg.png")
    let img1 = UIImage(named: "hearts.png")
    let img2 = UIImage(named: "loginBg.png")
    let img3 = UIImage(named: "reviewerImage.png")
    
    var parameters = [
        "emp_id": "1"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//
//        let imageData1 = img!.pngData()
//        let imageData2 = img1!.pngData()
//        let imageData3 = img2!.pngData()
//        let imageData4 = img3!.pngData()
//
//        let imageData : [Data] = [imageData1!,imageData2!,imageData3!,imageData4!]
//
//
        
        self.userNameView.layer.borderWidth = 0.5
        self.userNameView.layer.borderColor = UIColor.white.cgColor
        self.passwordView.layer.borderWidth = 0.5
        self.passwordView.layer.borderColor = UIColor.white.cgColor
        self.emailView.layer.borderWidth = 0.5
        self.emailView.layer.borderColor = UIColor.white.cgColor
    }
    
    


}
