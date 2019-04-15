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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_by_tabBtn"), object: nil, userInfo:["tab_btn_text":tabBtn.currentTitle!,"type":"local"])
    }
    
    func setFilterTabBtn(item:String){
        
        tabBtn.setTitle(item, for: .normal)
    }
}


