//
//  FilterPopUpViewController.swift
//  Collarub
//
//  Created by mac on 09/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import iOSDropDown

class FilterPopUpViewController: UIViewController {

    @IBOutlet weak var ratings: DropDown!
    @IBOutlet weak var engagementRate: DropDown!
    @IBOutlet weak var totalFollowers: DropDown!
    @IBOutlet weak var sector: DropDown!
    
    
    var rating : String = ""
    var engagert : String = ""
    var totalfolower : String = ""
    var sectr : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        engagementRate.optionArray = ["10%", "20%", "50%","100%"]
        ratings.optionArray = ["1", "2","3","4","5"]
        totalFollowers.optionArray = ["1000", "3000","6000","12000","20000"]
        sector.optionArray = ["Food", "Sports","Fashion","Beauty & healthcare","Events","Travel","Digital & Devices","Parenting","Home & Decor","Automotic","Pets"]
        
        engagementRate.arrowSize = 10
        ratings.selectedRowColor = UIColor.gray
        totalFollowers.selectedRowColor = UIColor.gray
        sector.selectedRowColor = UIColor.gray
        
        engagementRate.didSelect{(selectedText , index , id) in
            
              print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            self.engagert = selectedText
            
        }
        
        ratings.arrowSize = 10
        ratings.didSelect{(selectedText , index , id) in
            
            print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            
            self.rating = "\(selectedText).0"
        }
        
        totalFollowers.arrowSize = 10
        totalFollowers.didSelect{(selectedText , index , id) in
            
            print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            
            self.totalfolower = selectedText
        }
        
        sector.arrowSize = 10
        sector.didSelect{(selectedText , index , id) in
            
            print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            self.sectr = selectedText
            
        }
        
        
        
        
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
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil, userInfo: nil)

        }
    }
    @IBAction func searchBtn(_ sender: UIButton) {
        
        var arr : [String:String] = ["ratings":rating,"engagement_rate":engagert,"total_followers":totalfolower,"sector":sectr]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "searchArray"), object: nil, userInfo: arr)

        self.dismiss(animated: true, completion: nil)
        
    }
    
}
