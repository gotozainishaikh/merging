//
//  FindInfluencerTableViewCell.swift
//  Collarub
//
//  Created by mac on 09/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Cosmos

class FindInfluencerTableViewCell: UITableViewCell {

    var req_id : String!
    var reqDataDict :[String:String]!
    @IBOutlet weak var influencerName: UILabel!
    @IBOutlet weak var usrImg: UIImageView!
    @IBOutlet weak var influencerRating: CosmosView!
    @IBOutlet weak var influencerEngRate: UILabel!
    @IBOutlet weak var influencerSectors: UILabel!
    @IBOutlet weak var totalFollowers: UILabel!
    @IBOutlet weak var totalProjects: UILabel!
    @IBOutlet weak var hireBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @IBAction func hireClick(_ sender: UIButton) {
        reqDataDict = ["req_id": req_id]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hire"), object: nil, userInfo: reqDataDict)
    }
    
}
