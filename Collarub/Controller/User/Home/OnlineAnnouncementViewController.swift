//
//  OnlineAnnouncementViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 04/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import SVProgressHUD
import CoreData

class OnlineAnnouncementViewController: UIViewController{

    var category : String!
    var filter : String!
    
    var imageView : UIImageView!
    var type : String = "no text"
    var name : String = "no text"
    var category_name : String = "no text"
    
    var model : [OnlineModel] = [OnlineModel]()
    
    var favList : [String] = [String]()
    var favList2 : [String] = [String]()
    let url = FixVariable()
    
    var refresher:UIRefreshControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var status = false

    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("text=\(name)")
        
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.gray
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        
        
        
        
        if status {
            
            
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name(rawValue: "reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload2(notification:)), name: NSNotification.Name(rawValue: "reload_by_tabBtn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.get_filters(notification:)), name: NSNotification.Name(rawValue: "filters"), object: nil)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let imageName = "nodataavail.jpeg"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: self.view.frame.size.width  / 2 - 150, y: self.view.frame.size.height / 2, width: 300, height: 100)
        retriveData(){
            //model.removeAll()
            self.getFavCollab{
                print("self.favList2=\(self.favList2.count)")
                for item in self.favList2{
                    
                    print("favlistabc=\(item)")
                }
                for item in self.model{
                    
                    print("modelabc=\(item)")
                }
                print("relaod 1")
                self.collectionView.reloadData()
                
            }
        }
        imageView.tag = 100
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    @objc func reload(notification: NSNotification) {
        
        if let dict = notification.userInfo as NSDictionary? {
            if let name = dict["name"] as? String{
                
                self.name = name
                
            }
            if let type = dict["type"] as? String{
                
                self.type = type
                
            }
        }
        
        print("textaafter=\(self.name)")
        //        self.refresher = UIRefreshControl()
        //        self.collectionView!.alwaysBounceVertical = true
        //        self.refresher.tintColor = UIColor.gray
        //        self.refresher.addTarget(self, action: #selector(loadData2), for: .valueChanged)
        //        self.collectionView!.addSubview(refresher)
        
        //model.removeAll()
        retriveData(type: self.type, name: self.name){
            //model.removeAll()
            print("jhkdsh=\(self.model.count)")
            self.getFavCollab{
                
                print("byName")
                print("self.favList2=\(self.favList2.count)")
                for item in self.favList2{
                    
                    print("favlistabc=\(item)")
                }
                for item in self.model{
                    
                    print("modelabc=\(item)")
                }
                print("relaod 1")
                self.collectionView.reloadData()
                
            }
        }
        
    }
    @objc func reload2(notification: NSNotification) {
        
        if let dict = notification.userInfo as NSDictionary? {
            if let tab_btn_text = dict["tab_btn_text"] as? String{
                
                self.category_name = tab_btn_text
                
            }
            if let type = dict["type"] as? String{
                
                self.type = type
                
            }
        }
        
        //retriveData2(type: self.type, category_name: self.category_name)
        retriveData2(type: self.type, category_name: self.category_name){
            //model.removeAll()
            print("jhkdsh=\(self.model.count)")
            self.getFavCollab{
                
                print("byName")
                print("self.favList2=\(self.favList2.count)")
                for item in self.favList2{
                    
                    print("favlistabc=\(item)")
                }
                for item in self.model{
                    
                    print("modelabc=\(item)")
                }
                print("relaod 1")
                self.collectionView.reloadData()
                
            }
        }
    }
    @objc func loadData() {
        //code to execute during refresher
        
        retriveData(){
            print("relaod 2")
            print("modelCOUNT=\(self.model.count)")
            self.collectionView.reloadData()
        }
        stopRefresher()         //Call this to stop refresher
    }
    
    //    @objc func loadData2() {
    //        //code to execute during refresher
    //
    //        retriveData(type: self.type, name: self.name)
    //        stopRefresher()         //Call this to stop refresher
    //    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    func retriveFavList(user_id:String){
        
        let parameters : [String:String] = [
            
            "user_id": user_id
            
        ]
        
        
        
        Alamofire.request("\(self.url.weburl)/search_by_collaboration_name.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            SVProgressHUD.show(withStatus: "Connecting to server")
            
            if response.result.isSuccess {
                
                SVProgressHUD.dismiss()
                let dataJSON : JSON = JSON(response.result.value!)
                
                print("dataJSON2\(dataJSON)")
                let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                //  print(dataJSON.count)
                self.model.removeAll()
                
                for item in 0..<dataJSON.count {
                    //print(dataJSON[item])
                    // let onlineModel = OnlineModel()
                    SVProgressHUD.show(withStatus: "Loading")
                    let para : [String:Int] = [
                        "id" : dataJSON[item]["collaboration_id"].intValue
                    ]
                    Alamofire.request("\(self.url.weburl)/collabrubImages.php", method: .get, parameters: para).responseJSON { (response) in
                        
                        if response.result.isSuccess {
                            
                            let dataJSON1 : JSON = JSON(response.result.value!)
                            // let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                            //                            print(dataJSON[item])
                            //                             print(dataJSON1)
                            
                            let onlineModel = OnlineModel()
                            
                            
                            onlineModel.announcementImage = dataJSON1[0]["img_url"].stringValue
                            onlineModel.title = dataJSON[item]["collaboration_name"].stringValue
                            onlineModel.companyName = dataJSON[item]["company_name"].stringValue
                            onlineModel.location = dataJSON[item]["address"].stringValue
                            onlineModel.productImage = [dataJSON1[0]["img_url"].stringValue,dataJSON1[1]["img_url"].stringValue,dataJSON1[2]["img_url"].stringValue,dataJSON1[3]["img_url"].stringValue,dataJSON1[4]["img_url"].stringValue,dataJSON1[5]["img_url"].stringValue]
                            onlineModel.palceImages = ["",""]
                            onlineModel.reviews = ["",""]
                            onlineModel.date = dataJSON[item]["date"].stringValue
                            onlineModel.description = dataJSON[item]["descriptions"].stringValue
                            onlineModel.collaborattionTerms = dataJSON[item]["collaboration_terms"].stringValue
                            onlineModel.avalaibility = ""
                            onlineModel.selectedNumOfFollowers = dataJSON[item]["followers_limit"].stringValue
                            
                            onlineModel.collaboration_id = dataJSON[item]["collaboration_id"].stringValue
                            
                            onlineModel.expiry_date = dataJSON[item]["expiry_date"].stringValue
                            onlineModel.Accep_budget_check = dataJSON[item]["Accep_budget_check"].stringValue
                            onlineModel.budget_value = dataJSON[item]["budget_value"].stringValue
                            onlineModel.type = dataJSON[item]["type"].stringValue
                            onlineModel.discount_field = dataJSON[item]["discount_field"].stringValue
                            onlineModel.content_type = dataJSON[item]["content_type"].stringValue
                            onlineModel.required_city = dataJSON[item]["required_city"].stringValue
                            onlineModel.required_region = dataJSON[item]["required_region"].stringValue
                            onlineModel.engagement_rate = dataJSON[item]["engagement_rate"].stringValue
                            onlineModel.rating = dataJSON[item]["rating"].stringValue
                            onlineModel.user_gender = dataJSON[item]["user_gender"].stringValue
                            onlineModel.min_user_exp_level = dataJSON[item]["min_user_exp_level"].stringValue
                            onlineModel.category_name = dataJSON[item]["category_name"].stringValue
                            onlineModel.collab_limit = dataJSON[item]["collab_limit"].stringValue
                            self.model.append(onlineModel)
                            
                            //   SVProgressHUD.dismiss()
                            
                        }else {
                            print("error not get in first")
                        }
                        
                        print("count \(self.model.count)")
                        SVProgressHUD.dismiss()
                        print("relaod 3")
                        self.collectionView.reloadData()
                        
                    }
                }
                self.status = true
                
                
                
                super.viewDidLoad()
                
                
            }else {
                print("error not get in second")
            }
            
        }
        
        
    }
    
    func retriveData(completion: @escaping () -> Void){
        
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
        
        let parameters : [String:String] = [
            "collabrubType": "online"
        ]
        Alamofire.request("\(self.url.weburl)/all_collaboration.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            SVProgressHUD.show(withStatus: "Connecting to server")
            
            if response.result.isSuccess {
                
                SVProgressHUD.dismiss()
                let dataJSON : JSON = JSON(response.result.value!)
                //print("dataJSON1\(dataJSON)")
                
                let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                //  print(dataJSON.count)
                self.model.removeAll()
                if(dataJSON["Status"] != "failed"){
                    for item in 0..<dataJSON.count {
                        //print(dataJSON[item])
                        // let onlineModel = OnlineModel()
                        SVProgressHUD.show(withStatus: "Loading")
                        let para : [String:Int] = [
                            "id" : dataJSON[item]["collaboration_id"].intValue
                        ]
                        Alamofire.request("\(self.url.weburl)/collabrubImages.php", method: .get, parameters: para).responseJSON { (response) in
                            
                            if response.result.isSuccess {
                                
                                let dataJSON1 : JSON = JSON(response.result.value!)
                                // let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                                //                            print(dataJSON[item])
                                //                             print(dataJSON1)
                                
                                let onlineModel = OnlineModel()
                                
                                
                                onlineModel.announcementImage = dataJSON1[0]["img_url"].stringValue
                                onlineModel.title = dataJSON[item]["collaboration_name"].stringValue
                                onlineModel.companyName = dataJSON[item]["company_name"].stringValue
                                onlineModel.location = dataJSON[item]["address"].stringValue
                                onlineModel.productImage = [dataJSON1[0]["img_url"].stringValue,dataJSON1[1]["img_url"].stringValue,dataJSON1[2]["img_url"].stringValue,dataJSON1[3]["img_url"].stringValue,dataJSON1[4]["img_url"].stringValue,dataJSON1[5]["img_url"].stringValue]
                                onlineModel.palceImages = ["",""]
                                onlineModel.reviews = ["",""]
                                onlineModel.date = dataJSON[item]["date"].stringValue
                                onlineModel.description = dataJSON[item]["descriptions"].stringValue
                                onlineModel.collaborattionTerms = dataJSON[item]["collaboration_terms"].stringValue
                                onlineModel.avalaibility = ""
                                onlineModel.selectedNumOfFollowers = dataJSON[item]["followers_limit"].stringValue
                                
                                onlineModel.collaboration_id = dataJSON[item]["collaboration_id"].stringValue
                                
                                onlineModel.expiry_date = dataJSON[item]["expiry_date"].stringValue
                                onlineModel.Accep_budget_check = dataJSON[item]["Accep_budget_check"].stringValue
                                onlineModel.budget_value = dataJSON[item]["budget_value"].stringValue
                                onlineModel.type = dataJSON[item]["type"].stringValue
                                onlineModel.discount_field = dataJSON[item]["discount_field"].stringValue
                                onlineModel.content_type = dataJSON[item]["content_type"].stringValue
                                onlineModel.required_city = dataJSON[item]["required_city"].stringValue
                                onlineModel.required_region = dataJSON[item]["required_region"].stringValue
                                onlineModel.engagement_rate = dataJSON[item]["engagement_rate"].stringValue
                                onlineModel.rating = dataJSON[item]["rating"].stringValue
                                onlineModel.user_gender = dataJSON[item]["user_gender"].stringValue
                                onlineModel.min_user_exp_level = dataJSON[item]["min_user_exp_level"].stringValue
                                onlineModel.category_name = dataJSON[item]["category_name"].stringValue
                                onlineModel.collab_limit = dataJSON[item]["collab_limit"].stringValue
                                //                            onlineModel.isFav = dataJSON2[item]["isFav"].stringValue
                                self.model.append(onlineModel)
                                
                                //   SVProgressHUD.dismiss()
                                
                                
                            }else {
                                print("error not get in first")
                            }
                            
                            completion()
                            print("count \(self.model.count)")
                            SVProgressHUD.dismiss()
                            //                                self.collectionView.reloadData()
                            
                        }
                        
                    }
                }
                else{
                    completion()
                    self.view.addSubview(self.imageView)
                }
                self.status = true
                
                
                
                //                        super.viewDidLoad()
                
                
                
                
            }
            else {
                print("error not get in second")
            }
            
            
            
        }
        
        
        
        
    }
    
    func getFavCollab(completion: @escaping () -> Void){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
        
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        var user_id : String = res.value(forKey: "user_id") as! String
        let parameters : [String:String] = [
            
            "user_id": user_id
            
        ]
        Alamofire.request("\(self.url.weburl)/user_fav_collaborations.php", method: .get, parameters:parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                self.favList2.removeAll()
                
                let dataJSON2 : JSON = JSON(response.result.value!)
                
                print("dataJSON2.count\(dataJSON2.count)")
                
                for item in 0..<dataJSON2.count{
                    print("dataJSON2=\(dataJSON2[item]["collaboration_id"].intValue)")
                    let fav:String
                    
                    fav = dataJSON2[item]["collaboration_id"].stringValue
                    
                    self.favList2.append(fav)
                }
                
                
                //   SVProgressHUD.dismiss()
                
                
            }else {
                print("error not get in first")
            }
            completion()
            print("favList.count=\(self.favList.count)")
            SVProgressHUD.dismiss()
            print("relaod 4")
            self.collectionView.reloadData()
            
            
        }
        
    }
    
    func retriveData(type: String, name:String,completion: @escaping () -> Void){
        
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
        
        let parameters : [String:String] = [
            "collabrubType": "online",
            "collabrubName": name
            
        ]
        print("name=\(name)")
        print("type=\(type)")
        
        
        
        
        Alamofire.request("\(self.url.weburl)/search_by_collaboration_name.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            SVProgressHUD.show(withStatus: "Connecting to server")
            
            if response.result.isSuccess {
                
                SVProgressHUD.dismiss()
                let dataJSON : JSON = JSON(response.result.value!)
                //print("dataJSON1\(dataJSON)")
                
                let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                //  print(dataJSON.count)
                self.model.removeAll()
                if(dataJSON["Status"] != "failed"){
                    for item in 0..<dataJSON.count {
                        //print(dataJSON[item])
                        // let onlineModel = OnlineModel()
                        SVProgressHUD.show(withStatus: "Loading")
                        let para : [String:Int] = [
                            "id" : dataJSON[item]["collaboration_id"].intValue
                        ]
                        Alamofire.request("\(self.url.weburl)/collabrubImages.php", method: .get, parameters: para).responseJSON { (response) in
                            
                            if response.result.isSuccess {
                                
                                let dataJSON1 : JSON = JSON(response.result.value!)
                                // let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                                //                            print(dataJSON[item])
                                //                             print(dataJSON1)
                                
                                let onlineModel = OnlineModel()
                                
                                
                                onlineModel.announcementImage = dataJSON1[0]["img_url"].stringValue
                                onlineModel.title = dataJSON[item]["collaboration_name"].stringValue
                                onlineModel.companyName = dataJSON[item]["company_name"].stringValue
                                onlineModel.location = dataJSON[item]["address"].stringValue
                                onlineModel.productImage = [dataJSON1[0]["img_url"].stringValue,dataJSON1[1]["img_url"].stringValue,dataJSON1[2]["img_url"].stringValue,dataJSON1[3]["img_url"].stringValue,dataJSON1[4]["img_url"].stringValue,dataJSON1[5]["img_url"].stringValue]
                                onlineModel.palceImages = ["",""]
                                onlineModel.reviews = ["",""]
                                onlineModel.date = dataJSON[item]["date"].stringValue
                                onlineModel.description = dataJSON[item]["descriptions"].stringValue
                                onlineModel.collaborattionTerms = dataJSON[item]["collaboration_terms"].stringValue
                                onlineModel.avalaibility = ""
                                onlineModel.selectedNumOfFollowers = dataJSON[item]["followers_limit"].stringValue
                                
                                onlineModel.collaboration_id = dataJSON[item]["collaboration_id"].stringValue
                                
                                onlineModel.expiry_date = dataJSON[item]["expiry_date"].stringValue
                                onlineModel.Accep_budget_check = dataJSON[item]["Accep_budget_check"].stringValue
                                onlineModel.budget_value = dataJSON[item]["budget_value"].stringValue
                                onlineModel.type = dataJSON[item]["type"].stringValue
                                onlineModel.discount_field = dataJSON[item]["discount_field"].stringValue
                                onlineModel.content_type = dataJSON[item]["content_type"].stringValue
                                onlineModel.required_city = dataJSON[item]["required_city"].stringValue
                                onlineModel.required_region = dataJSON[item]["required_region"].stringValue
                                onlineModel.engagement_rate = dataJSON[item]["engagement_rate"].stringValue
                                onlineModel.rating = dataJSON[item]["rating"].stringValue
                                onlineModel.user_gender = dataJSON[item]["user_gender"].stringValue
                                onlineModel.min_user_exp_level = dataJSON[item]["min_user_exp_level"].stringValue
                                onlineModel.category_name = dataJSON[item]["category_name"].stringValue
                                onlineModel.collab_limit = dataJSON[item]["collab_limit"].stringValue
                                //                            onlineModel.isFav = dataJSON2[item]["isFav"].stringValue
                                self.model.append(onlineModel)
                                
                                //   SVProgressHUD.dismiss()
                                
                                
                            }else {
                                print("error not get in first")
                            }
                            
                            completion()
                            print("count \(self.model.count)")
                            SVProgressHUD.dismiss()
                            //                                self.collectionView.reloadData()
                            
                        }
                        
                    }
                }
                else{
                    completion()
                    self.view.addSubview(self.imageView)
                }
                self.status = true
                
                
                
                //                        super.viewDidLoad()
                
                
                
                
            }
            else {
                print("error not get in second")
            }
            
            
            
        }
        
        
    }
    
    func retriveData2(type: String, category_name:String,completion: @escaping () -> Void){
        
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
        
        let parameters : [String:String] = [
            "collabrubType": "online",
            "categoryName": category_name
            
        ]
        print("name=\(name)")
        print("type=\(type)")
        
        
        
        Alamofire.request("\(self.url.weburl)/search_by_category_name.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            SVProgressHUD.show(withStatus: "Connecting to server")
            
            if response.result.isSuccess {
                
                SVProgressHUD.dismiss()
                let dataJSON : JSON = JSON(response.result.value!)
                //print("dataJSON1\(dataJSON)")
                
                let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                //  print(dataJSON.count)
                self.model.removeAll()
                if(dataJSON["Status"] != "failed"){
                    for item in 0..<dataJSON.count {
                        //print(dataJSON[item])
                        // let onlineModel = OnlineModel()
                        SVProgressHUD.show(withStatus: "Loading")
                        let para : [String:Int] = [
                            "id" : dataJSON[item]["collaboration_id"].intValue
                        ]
                        Alamofire.request("\(self.url.weburl)/collabrubImages.php", method: .get, parameters: para).responseJSON { (response) in
                            
                            if response.result.isSuccess {
                                
                                let dataJSON1 : JSON = JSON(response.result.value!)
                                // let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                                //                            print(dataJSON[item])
                                //                             print(dataJSON1)
                                
                                let onlineModel = OnlineModel()
                                
                                
                                onlineModel.announcementImage = dataJSON1[0]["img_url"].stringValue
                                onlineModel.title = dataJSON[item]["collaboration_name"].stringValue
                                onlineModel.companyName = dataJSON[item]["company_name"].stringValue
                                onlineModel.location = dataJSON[item]["address"].stringValue
                                onlineModel.productImage = [dataJSON1[0]["img_url"].stringValue,dataJSON1[1]["img_url"].stringValue,dataJSON1[2]["img_url"].stringValue,dataJSON1[3]["img_url"].stringValue,dataJSON1[4]["img_url"].stringValue,dataJSON1[5]["img_url"].stringValue]
                                onlineModel.palceImages = ["",""]
                                onlineModel.reviews = ["",""]
                                onlineModel.date = dataJSON[item]["date"].stringValue
                                onlineModel.description = dataJSON[item]["descriptions"].stringValue
                                onlineModel.collaborattionTerms = dataJSON[item]["collaboration_terms"].stringValue
                                onlineModel.avalaibility = ""
                                onlineModel.selectedNumOfFollowers = dataJSON[item]["followers_limit"].stringValue
                                
                                onlineModel.collaboration_id = dataJSON[item]["collaboration_id"].stringValue
                                
                                onlineModel.expiry_date = dataJSON[item]["expiry_date"].stringValue
                                onlineModel.Accep_budget_check = dataJSON[item]["Accep_budget_check"].stringValue
                                onlineModel.budget_value = dataJSON[item]["budget_value"].stringValue
                                onlineModel.type = dataJSON[item]["type"].stringValue
                                onlineModel.discount_field = dataJSON[item]["discount_field"].stringValue
                                onlineModel.content_type = dataJSON[item]["content_type"].stringValue
                                onlineModel.required_city = dataJSON[item]["required_city"].stringValue
                                onlineModel.required_region = dataJSON[item]["required_region"].stringValue
                                onlineModel.engagement_rate = dataJSON[item]["engagement_rate"].stringValue
                                onlineModel.rating = dataJSON[item]["rating"].stringValue
                                onlineModel.user_gender = dataJSON[item]["user_gender"].stringValue
                                onlineModel.min_user_exp_level = dataJSON[item]["min_user_exp_level"].stringValue
                                onlineModel.category_name = dataJSON[item]["category_name"].stringValue
                                onlineModel.collab_limit = dataJSON[item]["collab_limit"].stringValue
                                //                            onlineModel.isFav = dataJSON2[item]["isFav"].stringValue
                                self.model.append(onlineModel)
                                
                                //   SVProgressHUD.dismiss()
                                
                                
                            }else {
                                print("error not get in first")
                            }
                            
                            completion()
                            print("count \(self.model.count)")
                            SVProgressHUD.dismiss()
                            //                                self.collectionView.reloadData()
                            
                        }
                        
                    }
                }
                else{
                    completion()
                    self.view.addSubview(self.imageView)
                }
                self.status = true
                
                
                
                //                        super.viewDidLoad()
                
                
                
                
            }
            else {
                print("error not get in second")
            }
            
            
            
        }
        
    }
    
    
    
    
    @objc func get_filters(notification: NSNotification) {
        
        
        if let dict = notification.userInfo as NSDictionary? {
            if let filter = dict["filter"] as? String{
                self.filter = filter
            }
            if let category = dict["category"] as? String{
                self.category = category
            }
            
        }
        print("filter="+self.filter)
        print("category="+self.category)
        
        get_col_by_filters(filter: self.filter, category: self.category){
            
            self.getFavCollab{
                print("self.favList2=\(self.favList2.count)")
                for item in self.favList2{
                    
                    print("favlistabc=\(item)")
                }
                for item in self.model{
                    
                    print("modelabc=\(item)")
                }
                print("relaod 1")
                self.collectionView.reloadData()
                
            }
            
        }
        
        
    }
    
    func get_col_by_filters(filter:String, category: String, completion: @escaping () -> Void){
        
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
        
        let parameters : [String:String] = [
            "collabrubType": "online",
            "category": category,
            filter : "1"
        ]
        Alamofire.request("\(self.url.weburl)/userMultisearch.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            SVProgressHUD.show(withStatus: "Connecting to server")
            
            if response.result.isSuccess {
                
                SVProgressHUD.dismiss()
                let dataJSON : JSON = JSON(response.result.value!)
                //print("dataJSON1\(dataJSON)")
                
                let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                //  print(dataJSON.count)
                self.model.removeAll()
                if(dataJSON["Status"] != "failed"){
                    for item in 0..<dataJSON.count {
                        //print(dataJSON[item])
                        // let onlineModel = OnlineModel()
                        SVProgressHUD.show(withStatus: "Loading")
                        let para : [String:Int] = [
                            "id" : dataJSON[item]["collaboration_id"].intValue
                        ]
                        Alamofire.request("\(self.url.weburl)/collabrubImages.php", method: .get, parameters: para).responseJSON { (response) in
                            
                            if response.result.isSuccess {
                                
                                let dataJSON1 : JSON = JSON(response.result.value!)
                                // let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                                //                            print(dataJSON[item])
                                //                             print(dataJSON1)
                                
                                let onlineModel = OnlineModel()
                                
                                
                                onlineModel.announcementImage = dataJSON1[0]["img_url"].stringValue
                                onlineModel.title = dataJSON[item]["collaboration_name"].stringValue
                                onlineModel.companyName = dataJSON[item]["company_name"].stringValue
                                onlineModel.location = dataJSON[item]["address"].stringValue
                                onlineModel.productImage = [dataJSON1[0]["img_url"].stringValue,dataJSON1[1]["img_url"].stringValue,dataJSON1[2]["img_url"].stringValue,dataJSON1[3]["img_url"].stringValue,dataJSON1[4]["img_url"].stringValue,dataJSON1[5]["img_url"].stringValue]
                                onlineModel.palceImages = ["",""]
                                onlineModel.reviews = ["",""]
                                onlineModel.date = dataJSON[item]["date"].stringValue
                                onlineModel.description = dataJSON[item]["descriptions"].stringValue
                                onlineModel.collaborattionTerms = dataJSON[item]["collaboration_terms"].stringValue
                                onlineModel.avalaibility = ""
                                onlineModel.selectedNumOfFollowers = dataJSON[item]["followers_limit"].stringValue
                                
                                onlineModel.collaboration_id = dataJSON[item]["collaboration_id"].stringValue
                                
                                onlineModel.expiry_date = dataJSON[item]["expiry_date"].stringValue
                                onlineModel.Accep_budget_check = dataJSON[item]["Accep_budget_check"].stringValue
                                onlineModel.budget_value = dataJSON[item]["budget_value"].stringValue
                                onlineModel.type = dataJSON[item]["type"].stringValue
                                onlineModel.discount_field = dataJSON[item]["discount_field"].stringValue
                                onlineModel.content_type = dataJSON[item]["content_type"].stringValue
                                onlineModel.required_city = dataJSON[item]["required_city"].stringValue
                                onlineModel.required_region = dataJSON[item]["required_region"].stringValue
                                onlineModel.engagement_rate = dataJSON[item]["engagement_rate"].stringValue
                                onlineModel.rating = dataJSON[item]["rating"].stringValue
                                onlineModel.user_gender = dataJSON[item]["user_gender"].stringValue
                                onlineModel.min_user_exp_level = dataJSON[item]["min_user_exp_level"].stringValue
                                onlineModel.category_name = dataJSON[item]["category_name"].stringValue
                                onlineModel.collab_limit = dataJSON[item]["collab_limit"].stringValue
                                //                            onlineModel.isFav = dataJSON2[item]["isFav"].stringValue
                                self.model.append(onlineModel)
                                
                                //   SVProgressHUD.dismiss()
                                
                                
                            }else {
                                print("error not get in first")
                            }
                            
                            completion()
                            print("count \(self.model.count)")
                            SVProgressHUD.dismiss()
                            //                                self.collectionView.reloadData()
                            
                        }
                        
                    }
                }
                else{
                    self.view.addSubview(self.imageView)
                }
                self.status = true
                
                
                
                //                        super.viewDidLoad()
                
                
                
                
            }
            else {
                print("error not get in second")
            }
            
            
            
        }
        
        
        
        
    }
    
    

}


extension OnlineAnnouncementViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if((model.count>0)&&(model[0].collaboration_id == "0")){
            print("(model[0].collaboration_id)=\((model[0].collaboration_id))")
            model.removeAll()
        }
        
        print("model.count=\(model.count)")
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test1", for: indexPath) as! OnlineAnnouncementCollectionViewCell
       
        cell.imgOnline.sd_setImage(with: URL(string: model[indexPath.row].announcementImage))
        
        cell.announcementTitle.text = model[indexPath.row].title
        cell.category.text = model[indexPath.row].category_name
        cell.end_date.text = model[indexPath.row].expiry_date
        cell.remaining_req.text = model[indexPath.row].collab_limit
        cell.followersRequired.text = model[indexPath.row].selectedNumOfFollowers
        cell.col_id = model[indexPath.row].collaboration_id
        cell.setLikeMe(isFav: favList2)
        
        cell.imgOnline.layer.cornerRadius = 6
        cell.imgOnline.clipsToBounds = true
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 5
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 154)
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        if let index = indexPath {
            
            
            self.performSegue(withIdentifier: "gotoDetailOnlinePage", sender: model[(indexPath?.row)!])
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoDetailOnlinePage" {
            let destinationVC = segue.destination as! LocalDetailsViewController
            
            destinationVC.onlineArray = (sender as? OnlineModel!)
            
        }
    }
    
}
