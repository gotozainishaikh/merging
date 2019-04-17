//
//  HistoryReviewPopUpViewController.swift
//  Collarub
//
//  Created by mac on 10/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
import SwiftyJSON

class HistoryReviewPopUpViewController: UIViewController,UITextViewDelegate {

    
     let url = FixVariable()
    var model = FavListModel()
    @IBOutlet weak var giveRate: CosmosView!
    @IBOutlet weak var reviewText: UITextView!
    var review : String = "Type your review"
    var rat : String = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
print(model.user_id)
        reviewText.delegate = self
        showAnimate()
       giveRate.settings.fillMode = .precise
        giveRate.rating = 0.0

        giveRate.didFinishTouchingCosmos = { rating in
            self.rat = String(rating)
        }
    }
    @IBAction func saveReview(_ sender: UIButton) {
        reviewText.endEditing(true)
        
        if (review != "Type your review" && review != "" && rat != "0.0"){

            print("\(review) :: \(rat) :: \(model.collaboration_id) :: \(model.user_id)")
            let parameters : [String:String] = [
                "partner_review": review,
                "partner_rate": rat,
                "campaign_id": model.collaboration_id,
                "user_id":model.user_id

            ]

            Alamofire.request("\(self.url.weburl)/rate_user.php", method: .get, parameters: parameters).responseJSON { (response) in

                if response.result.isSuccess {

                    let dataJSON : JSON = JSON(response.result.value!)

                    print(dataJSON)
                    
                    self.dismiss(animated: true, completion: nil)
                }
            }

        }else {
            let alert = UIAlertController(title: "Warning", message: "Please give review and ratings", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
        }
        
        
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "Type your review" {
            textView.text = ""
            textView.textColor = UIColor.black
           // review = textView.text
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Type your review"
            textView.textColor = UIColor.lightGray
            review = ""
            
        }else {
            review = textView.text
            
        }
    }
}
