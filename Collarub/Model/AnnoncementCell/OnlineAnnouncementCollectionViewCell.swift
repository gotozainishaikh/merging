//
//  OnlineAnnouncementCollectionViewCell.swift
//  Collarub
//
//  Created by Zain Shaikh on 08/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class OnlineAnnouncementCollectionViewCell: UICollectionViewCell {
    
      var isFav : String!
    var stat : String = ""
    @IBOutlet weak var imgOnline: UIImageView!
    @IBOutlet weak var announcementTitle: UILabel!
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var followersRequired: UILabel!
    @IBOutlet weak var end_date: UILabel!
    @IBOutlet weak var remaining_req: UILabel!
    @IBOutlet weak var likeMe: UIButton!
    var col_id :String!
    let url = FixVariable()
    var isLike = false
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
    
    
    func setLikeMe(isFav:[String]){
        
        print("setLike=\(col_id)")
        let hasFav = isFav.contains(col_id)
        print("hasFav=\(hasFav)")
        if(hasFav==true){
            likeMe.setImage(UIImage(named: "hearts"), for: .normal)
            self.isLike = true
             stat = "1"
        }
        else if(hasFav==false){
            likeMe.setImage(UIImage(named: "like"), for: .normal)
            self.isLike = false
            stat = "0"
        }
        //        for item in isFav {
        //            if(item==col_id){
        //                likeMe.setImage(UIImage(named: "hearts"), for: .normal)
        //            }
        //        }
        
    }
    
    
    @IBAction func likeBtn(_ sender: UIButton) {
        
        
        
        sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: .allowUserInteraction,
                       animations: {
                        sender.transform = .identity
                        if self.isLike {
                            sender.setImage(UIImage(named: "like"), for: .normal)
                            self.isLike = false
                        }else {
                            sender.setImage(UIImage(named: "hearts"), for: .normal)
                            self.isLike = true
                        }
        },
                       completion: { finished in
                        // self.animateButton()
                        let results : NSArray = try! self.context.fetch(self.request) as NSArray
                        
                        let res = results[0] as! NSManagedObject
                        
                        var id : String = res.value(forKey: "user_id") as! String
                        
                        
                        print(self.col_id!)
                        
                        
                        let parameters : [String:String] = [
                            "user_id": id,
                            "collaboration_id": String(self.col_id)
                            
                        ]
                        
                        
                        Alamofire.request("\(self.url.weburl)/favourite_list_of_user.php", method: .get, parameters: parameters).responseJSON { (response) in
                            
                            if response.result.isSuccess {
                                
                                let dataJSON : JSON = JSON(response.result.value!)
                                
                                print(dataJSON)
                            }
                        }
                        //    myfunc()
                        
                        
        }
        )
        
        
    }
    
    
}
