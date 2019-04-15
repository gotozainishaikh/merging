//
//  LocalAnnouncementCollectionViewCell.swift
//  Collarub
//
//  Created by Mac 1 on 10/17/1397 AP.
//  Copyright © 1397 Mac 1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class LocalAnnouncementCollectionViewCell: UICollectionViewCell {
    
    var isFav : String!
    @IBOutlet weak var imgLocal: UIImageView!
    @IBOutlet weak var announcementTitle: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var followersRequired: UILabel!
    @IBOutlet weak var likeMe: UIButton!
    var col_id :String!
    let url = FixVariable()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
    
    
    func setLikeMe(isFav:[String]){
        
        let hasFav = isFav.contains(col_id)
        print("hasFav=\(hasFav)")
        if(hasFav==true){
            likeMe.setImage(UIImage(named: "hearts"), for: .normal)
        }
        else if(hasFav==false){
            likeMe.setImage(UIImage(named: "like"), for: .normal)
        }
        //        for item in isFav {
        //            if(item==col_id){
        //                likeMe.setImage(UIImage(named: "hearts"), for: .normal)
        //            }
        //        }
        
    }
    
    
    @IBAction func likeBtn(_ sender: UIButton) {
        
        var isLike = false
        
        sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: .allowUserInteraction,
                       animations: {
                        sender.transform = .identity
                        if isLike {
                            sender.setImage(UIImage(named: "like"), for: .normal)
                            isLike = false
                        }else {
                            sender.setImage(UIImage(named: "hearts"), for: .normal)
                            isLike = true
                        }
        },
                       completion: { finished in
                        // self.animateButton()
                        let results : NSArray = try! self.context.fetch(self.request) as NSArray
                        
                        let res = results[0] as! NSManagedObject
                        
                        var id : String = res.value(forKey: "user_id") as! String
                        
                        
                        print(self.col_id)
                        
                        
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
    
    // func myfunc(inde : IndexPath) {
    
    
    
}
