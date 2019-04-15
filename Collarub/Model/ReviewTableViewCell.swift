//
//  ReviewTableViewCell.swift
//  Collarub
//
//  Created by Zain Shaikh on 18/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Cosmos
class ReviewTableViewCell: UITableViewCell {

    var startRating:Double = 0.0
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var reviewerImg: UIImageView!
    @IBOutlet weak var reviewerName: UILabel!
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //ratings(ratingValue: startRating)
        
    }
    
    func ratings(ratingValue: Double){
        ratingView.settings.updateOnTouch = false
        ratingView.settings.totalStars = 5
        ratingView.settings.fillMode = .precise
        ratingView.rating = ratingValue
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
