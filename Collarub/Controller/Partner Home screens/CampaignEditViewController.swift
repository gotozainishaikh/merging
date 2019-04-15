//
//  CampaignEditViewController.swift
//  Collarub
//
//  Created by mac on 03/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import iOSDropDown
import Cosmos


class CampaignEditViewController: UIViewController {

    @IBOutlet weak var usrRevieTxt: UITextView!
    var model = FavListModel()
    var addressStrin = [String]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ratingByUser: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    tableView.tableFooterView = UIView()
        addressStrin = model.url.components(separatedBy: ",")
//        for item in 0..<addressStrin.count {
//           print("data \(addressStrin[item])")
//        }
        tableView.reloadData()
        usrRevieTxt.text = model.user_give_review
        ratingByUser.settings.updateOnTouch = false
        ratingByUser.settings.totalStars = 5
        ratingByUser.settings.fillMode = .precise
        
        ratingByUser.rating =  Double(model.user_give_rating) ?? 0.0
            // self.selectedtex = selectedText
        }
        // Do any additional setup after loading the view.
    
   
    @IBAction func cncel(_ sender: UIButton) {
       self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rateBtn(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "RatePopUp") as! HistoryReviewPopUpViewController
        
        vc.model = model
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    

}


extension CampaignEditViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressStrin.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = addressStrin[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
        
        //  self.performSegue(withIdentifier: "requestList", sender: nil)
        
    }
    
    
    
}

