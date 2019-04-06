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

class PartnerContainerViewController: UIViewController {

    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    @IBOutlet weak var settingOptionView: UIView!
    @IBOutlet weak var otherOption: UIView!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var userImg: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingOptionView.isHidden = true

        uiNavegationImage()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration") 
            
        
        
        
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
        }
        
       
        
        
        
       // print(res.value(forKey: "userName"))
    }
    
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    
    

    
    func ratings(ratingValue: Double){
//        ratingView.settings.updateOnTouch = false
//        ratingView.settings.totalStars = 5
//        ratingView.settings.fillMode = .precise
//        ratingView.rating = ratingValue
    }
    
    
    
    @IBAction func settingOnclick(_ sender: UIButton) {
        
        if self.settingOptionView.isHidden {
            self.settingOptionView.isHidden = false
            self.topConstraints.constant = 100.0
        }else {
            self.settingOptionView.isHidden = true
             self.topConstraints.constant = 0.0
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
