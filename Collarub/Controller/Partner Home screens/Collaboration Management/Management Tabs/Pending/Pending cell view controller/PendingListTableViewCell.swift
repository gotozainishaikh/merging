//
//  PendingListTableViewCell.swift
//  Collarub
//
//  Created by mac on 13/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class PendingListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var usrImg: UIImageView!
    @IBOutlet weak var advertisementTitle: UILabel!
    @IBOutlet weak var advertisementDetails: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
