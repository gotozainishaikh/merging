//
//  CollectionViewCell.swift
//  Collarub
//
//  Created by Zain Shaikh on 06/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tabBtn: UIButton!
    @IBAction func tabBtnOnclick(_ sender: UIButton) {
        
       isSelected = true
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_by_tabBtn"), object: nil, userInfo:["tab_btn_text":tabBtn.currentTitle!,"type":"local"])
    }
    

    func setFilterTabBtn(image_item:String, title_item:String){
        
        print("image_item=\(image_item)")
        tabBtn.setImage(UIImage(named: image_item), for: .normal)
        
        tabBtn.setTitle(title_item, for: .normal)
        
    }
    
    
    override var isSelected: Bool{
        
        didSet{
            
            if self.isSelected{
                
                print("selected")
            }
            
            else{
                
                print("not")
            }
            
        }
//        didSet{
//            if self.isSelected
//            {
//                print("tabBtn.currentTitle\(tabBtn.currentTitle!)")
//
//                print("ifh")
//
//                switch tabBtn.currentTitle! {
//
//                case "Food":
//                    tabBtn.setImage(#imageLiteral(resourceName: "food-1"), for: .normal)
//
//                case "Sport":
//                    tabBtn.setImage(#imageLiteral(resourceName: "sports-1"), for: .normal)
//
//                case "Fashion":
//                    tabBtn.setImage(#imageLiteral(resourceName: "fashion-1"), for: .normal)
//
//                case "Beauty":
//                    tabBtn.setImage(#imageLiteral(resourceName: "beauty-1"), for: .normal)
//
//                case "Events":
//                    tabBtn.setImage(#imageLiteral(resourceName: "events-1"), for: .normal)
//
//                case "Travel":
//                    tabBtn.setImage(#imageLiteral(resourceName: "travel-1"), for: .normal)
//
//                case "Digital":
//                    tabBtn.setImage(#imageLiteral(resourceName: "digital-1"), for: .normal)
//
//                case "Parenting":
//                    tabBtn.setImage(#imageLiteral(resourceName: "parenting-1"), for: .normal)
//
//                case "Home":
//                    tabBtn.setImage(#imageLiteral(resourceName: "home-1"), for: .normal)
//
//                case "Automotive":
//                    tabBtn.setImage(#imageLiteral(resourceName: "driving-1"), for: .normal)
//
//                case "Pets":
//                    tabBtn.setImage(#imageLiteral(resourceName: "pets-1"), for: .normal)
//
//
//                default:
//                    print("default")
//                }
//            }
//            else
//            {
//                 print("elseh")
//                print("tabBtn.currentTitle\(tabBtn.currentTitle!)")
//
//
//
//                switch tabBtn.currentTitle! {
//
//                case "Food":
//                    tabBtn.setImage(UIImage(named: "food"), for: .normal)
//
//                case "Sport":
//                    tabBtn.setImage(UIImage(named: "sports"), for: .normal)
//
//                case "Fashion":
//                    tabBtn.setImage(UIImage(named: "fashion"), for: .normal)
//
//                case "Beauty":
//                    tabBtn.setImage(UIImage(named: "beauty"), for: .normal)
//
//                case "Events":
//                     tabBtn.setImage(UIImage(named: "events"), for: .normal)
//
//                case "Travel":
//                     tabBtn.setImage(UIImage(named: "travel"), for: .normal)
//
//                case "Digital":
//                     tabBtn.setImage(UIImage(named: "digital"), for: .normal)
//
//                case "Parenting":
//                     tabBtn.setImage(UIImage(named: "parenting"), for: .normal)
//
//                case "Home":
//                     tabBtn.setImage(UIImage(named: "home1"), for: .normal)
//
//                case "Automotive":
//                     tabBtn.setImage(UIImage(named: "driving"), for: .normal)
//
//                case "Pets":
//                     tabBtn.setImage(UIImage(named: "pets"), for: .normal)
//
//
//                default:
//                    print("default")
//                }
//            }
//        }
    }
    
    
}


