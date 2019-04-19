//
//  MyProfileViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 15/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Cosmos
import CoreData
import SDWebImage

class MyProfileViewController: UIViewController {

    let story = UIStoryboard(name: "User", bundle: nil)
    let startRating:Double = 2.3
    
    //Alamofire
    let api = AlamofireApi()
    
    //base Url
    let base_url = FixVariable()
    
    //User_id
    var user_id : String!
    
    //User Type
    var user_type : String!
    
    //Outlets
    @IBOutlet weak var usrName: UILabel!
    @IBOutlet weak var userImg: UIButton!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var eng_rate: UILabel!
    
    @IBOutlet weak var user_type_img: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eng_rate.text = ""
        user_type_img.image = UIImage(named: "")
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
        
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        user_id = res.value(forKey: "user_id") as! String

        //Image Round
        userImg.layer.cornerRadius = userImg.frame.size.width/2
        userImg.clipsToBounds = true
        
        ratings(ratingValue: startRating)
        
        
//        let button1 = UIBarButtonItem(image: UIImage(named: "togglt"), style: .plain, target: self, action: #selector(action))
        
        let button2 = UIBarButtonItem(image: UIImage(named: "bell-icon"), style: .plain, target: self, action: #selector(actionFavList))
        
//        self.navigationItem.leftBarButtonItem  = button1
       
        
        self.navigationItem.rightBarButtonItem  = button2
        
        uiNavegationImage()
        
        
        let url = "\(base_url.weburl)/find_engagement_rate.php"
        
        api.alamofireApiWithParams(url: url, parameters: ["id": user_id]){
            
            json in
            
            self.eng_rate.text = "\(json["percentage"].stringValue)%"
            
            
        }
        get_user_type {
            
            print("userType=\(self.user_type)")
            if(self.user_type == "1"){
                self.user_type_img.image = UIImage(named: "free")
            }
            else{
                self.user_type_img.image = UIImage(named: "2")
            }
        }
        
    }
    
    @IBAction func plan_btn(_ sender: UIButton) {
        
        
        let vc = story.instantiateViewController(withIdentifier: "UserPlan")
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
       
       
        let vc = story.instantiateViewController(withIdentifier: "popUp")
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    @IBAction func share_btn(_ sender: UIButton) {
        
        
        let textToShare = "Swift is awesome!  Check out this website about it!"
        
        if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    
    func ratings(ratingValue: Double){
        ratingView.settings.updateOnTouch = false
        ratingView.settings.totalStars = 5
        ratingView.settings.fillMode = .precise
        ratingView.rating = ratingValue
    }
    
    // MARK: navigation image
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    
    // MARK: ACTION SIDE MENU
    
//    @objc func action(){
//        performSegue(withIdentifier: "sideMenu", sender: self)
//    }
    
    @objc func actionFavList(){
       
        let vc = story.instantiateViewController(withIdentifier: "FavList")
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
        
        
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        let pic : String = res.value(forKey: "profile_picture") as! String
        let follower : Int64 = res.value(forKey: "followers") as! Int64
        let name : String = res.value(forKey: "username") as! String
        userImg.sd_setImage(with: URL(string: pic), for: .normal)
        followers.text = "\(follower)"
        usrName.text = name
        print(res.value(forKey: "username"))
    }

    @IBAction func logOut(_ sender: UIButton) {
        
let storyMain = UIStoryboard(name: "Main", bundle: nil)
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                if cookie.domain.contains(".instagram.com") {
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                }
            }
            
                    Defaults.setLoginStatus(logInStatus: false)
            
                    let vc = storyMain.instantiateViewController(withIdentifier: "mainScreen")
                    present(vc, animated: true, completion: nil)
            
            deleteAllRecords()
            
        }
        
        
        
    }
    
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func get_user_type(completion: @escaping () -> Void){
        
        let url = "\(base_url.weburl)/get_user_type.php"
        api.alamofireApiWithParams(url: url
        , parameters: ["user_id":user_id]){
            json in
            
            self.user_type = json[0]["user_type"].stringValue
            
            completion()
        }
        
    }


}
