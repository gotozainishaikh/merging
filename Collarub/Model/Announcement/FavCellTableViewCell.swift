//
//  FavCellTableViewCell.swift
//  Collarub
//
//  Created by Zain Shaikh on 17/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import SwipeCellKit
class FavCellTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var usrImg: UIImageView!
    @IBOutlet weak var advertisementTitle: UILabel!
    @IBOutlet weak var advertisementDetails: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // dateLabel.isHidden = true
        // Configure the view for the selected state
    }
    
}
