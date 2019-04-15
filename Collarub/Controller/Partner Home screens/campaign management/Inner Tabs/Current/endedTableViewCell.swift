//
//  endedTableViewCell.swift
//  Collarub
//
//  Created by mac on 06/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class endedTableViewCell: UITableViewCell {

    var model = LocalModel()
    @IBOutlet weak var imgUsr: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var decrip: UILabel!
    @IBOutlet weak var budgt: UILabel!
    var reqDataDict :[String:Any]!
    var req_id : String!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func repeatBtn(_ sender: UIButton) {
        reqDataDict = ["req_id": req_id,"modal": model]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reqreject"), object: nil, userInfo: reqDataDict)
    }
}
