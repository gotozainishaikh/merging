//
//  TableViewCell.swift
//  Collarub
//
//  Created by Zain Shaikh on 01/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var req_id : String!
    var reqDataDict :[String:String]!
    @IBOutlet weak var usrImg: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var usrName: UILabel!
    @IBOutlet weak var followrs: UILabel!
    @IBOutlet weak var locName: UILabel!
    @IBOutlet weak var noFound: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.borderWidth = 0.7
        mainView.layer.borderColor = UIColor.black.cgColor
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func rejectBtn(_ sender: UIButton) {
        reqDataDict = ["req_id": req_id]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reqreject"), object: nil, userInfo: reqDataDict)
    }
    
    @IBAction func accpt(_ sender: UIButton) {
        
        reqDataDict = ["req_id": req_id]
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reqAcp"), object: nil, userInfo: reqDataDict)
        
    }
    
    
    
}
