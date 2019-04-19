//
//  ReportViewViewController.swift
//  Collarub
//
//  Created by mac on 19/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
class ReportViewViewController: UIViewController {

    @IBOutlet weak var totalRequest: UILabel!
    @IBOutlet weak var totalInfluencer: UILabel!
    @IBOutlet weak var totalFav: UILabel!
    @IBOutlet weak var totalReviews: UILabel!
    @IBOutlet weak var totalBudget: UILabel!
    
    var url = FixVariable()
    var col_id : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        print("ïd :: \(col_id)")
        let parameters : [String:String] = [
            
            "campaign_id": col_id
        ]
        
        Alamofire.request("\(self.url.weburl)/get_collaboration_report.php", method: .get, parameters: parameters).responseJSON { (response) in
            SVProgressHUD.show(withStatus: "Loading")
            if response.result.isSuccess {
                SVProgressHUD.dismiss()
                let dataJSON1 : JSON = JSON(response.result.value!)
                
                self.totalRequest.text = dataJSON1["total_requests"].stringValue
                self.totalInfluencer.text = dataJSON1["hired_influencers"].stringValue
                self.totalFav.text = dataJSON1["count_of_campaign_fav"].stringValue
                self.totalReviews.text = dataJSON1["review_total"].stringValue
                self.totalBudget.text = dataJSON1["budget"].stringValue
                
                SVProgressHUD.dismiss()
                    //SVProgressHUD.showSuccess(withStatus: "Done")
                    
                
            }
            
        }
       
    }
    

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
