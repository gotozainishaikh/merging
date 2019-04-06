//
//  CurrentListTableViewCell.swift
//  Collarub
//
//  Created by Zain Shaikh on 11/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import SwipeCellKit

class CurrentListTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var imgUsr: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var decrip: UILabel!
    @IBOutlet weak var budgt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
