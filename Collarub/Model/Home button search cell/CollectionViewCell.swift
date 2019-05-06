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
        
        print("tabBtn.currentTitle\(tabBtn.currentTitle!)")
        tabBtn.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_by_tabBtn"), object: nil, userInfo:["tab_btn_text":tabBtn.currentTitle!,"type":"local"])
    }
    
//    func setFilterTabBtn(item:String){
//
//        tabBtn.setTitle(item, for: .normal)
//    }
    func setFilterTabBtn(image_item:String, title_item:String){
        
        print("image_item=\(image_item)")
        tabBtn.setImage(UIImage(named: image_item), for: .normal)
        
        tabBtn.setTitle(title_item, for: .normal)
        
    }
}


