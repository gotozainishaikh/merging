//
//  PartnerContainerViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 02/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import CoreData
import Cosmos
import SDWebImage
import Alamofire
import SwiftyJSON

class PartnerContainerViewController: UIViewController {

    @IBOutlet weak var switchNotification: UISwitch!
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    @IBOutlet weak var rateNum: UILabel!
    @IBOutlet weak var settingOptionView: UIView!
    @IBOutlet weak var otherOption: UIView!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var engagementRt: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var userImg: UIButton!
    @IBOutlet weak var uparrowimg: UIImageView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
    var url = FixVariable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchNotification.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        settingOptionView.isHidden = true

        ratings()
        uiNavegationImage()
        // Do any additional setup after loading the view.
    }
    
    func retriveData(id:String){
        
        let para : [String:String] = ["id" : id]
        Alamofire.request("\(self.url.weburl)/find_partner_engagement_rate.php", method: .get, parameters: para).responseJSON { (response) in
            // SVProgressHUD.show(withStatus: "Connecting to server")
            if response.result.isSuccess {
                
                //   SVProgressHUD.dismiss()
                
                let dataJSON : JSON = JSON(response.result.value!)
                
                if dataJSON["Status"] != "failed" {
                    self.engagementRt.text = "\(dataJSON["engagement"].stringValue)%"
                    
                    let para1 : [String:String] = ["id" : id]
                    Alamofire.request("\(self.url.weburl)/find_partner_level.php", method: .get, parameters: para).responseJSON { (response) in
                        
                        if response.result.isSuccess {
                            
                            let dataJSON : JSON = JSON(response.result.value!)
                            
                            if dataJSON["Status"] == "success" {
                                self.ratingView.rating = dataJSON["level"].doubleValue
                                self.rateNum.text = "Ratting \(dataJSON["level"].intValue)/5"
                            }
                        }
                    }
                }else {
                    self.retriveData(id: id)
                }
            }
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
       
        
            
        
        
        
        if let results : NSArray = try! context.fetch(request) as NSArray {
            let res = results[0] as! NSManagedObject
            
            if let pic : String = res.value(forKey: "profile_picture") as! String {
                userImg.sd_setImage(with: URL(string: pic), for: .normal)
            }
            if let follower : Int64 = res.value(forKey: "followers") as! Int64 {
                followerLabel.text = "\(follower)"
            }
            if let name : String = res.value(forKey: "userName") as! String {
                nameLabel.text = name
            }
            if let id : String = res.value(forKey: "user_id") as! String {
                retriveData(id: id)
            }
        }
        
       
        
        
        
       // print(res.value(forKey: "userName"))
    }
    
    @IBAction func helpBtn(_ sender: Any) {
        
        
    }
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    
    
    @IBAction func myReviews(_ sender: UIButton) {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "partnerReview")
        present(vc!, animated: true, completion: nil)
        
        
    }
    @IBAction func top50Btn(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "top50")
        present(vc!, animated: true, completion: nil)
        
    }
    
    
    func ratings(){
        ratingView.settings.updateOnTouch = false
        ratingView.settings.totalStars = 5
        ratingView.settings.fillMode = .precise
//        ratingView.rating = ratingValue
    }
    
    
    
    @IBAction func settingOnclick(_ sender: UIButton) {
        
        if self.settingOptionView.isHidden {
            self.settingOptionView.isHidden = false
            self.topConstraints.constant = 60.0
            uparrowimg.image = UIImage(named: "angle-arrow-down")
        }else {
            self.settingOptionView.isHidden = true
             self.topConstraints.constant = 0.0
            uparrowimg.image = UIImage(named: "up-arrow")
        }
    }
    @IBAction func logoutAction(_ sender: UIButton) {
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                if cookie.domain.contains(".instagram.com") {
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                }
            }
            
            Defaults.setPartnerLoginStatus(logInStatus: false)
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "mainScreen")
            present(vc, animated: true, completion: nil)
            
            deleteAllRecords()
            
        }
        
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    

}
