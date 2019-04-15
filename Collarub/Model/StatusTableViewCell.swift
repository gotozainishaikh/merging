//
//  StatusTableViewCell.swift
//  Collarub
//
//  Created by Zain Shaikh on 21/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {

    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var advertisementHeading: UILabel!
    @IBOutlet weak var statusDescription: UILabel!
    @IBOutlet weak var dateNum: UILabel!
    @IBOutlet weak var monthName: UILabel!
    
    @IBOutlet weak var whatStatus: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
