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

class OnlineAnnouncementViewController: UIViewController{

    var model : [OnlineModel] = [OnlineModel]()
    
    var refresher:UIRefreshControl!
    
    let url = FixVariable()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.gray
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        
        
        retriveData()
        // Do any additional setup after loading the view.
    }
    
    
    

    
    @objc func loadData() {
        //code to execute during refresher
        
        retriveData()
        stopRefresher()         //Call this to stop refresher
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func retriveData(){
        
        
        let parameters : [String:String] = [
            "collabrubType": "online"
            
        ]
        
        Alamofire.request("\(self.url.weburl)/all_collaboration.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let dataJSON : JSON = JSON(response.result.value!)
                let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                //  print(dataJSON.count)
                
                self.model.removeAll()
                for item in 0..<dataJSON.count {
                    //print(dataJSON[item])
                    // let localModel = LocalModel()
                    SVProgressHUD.show(withStatus: "Loading")
                    let para : [String:Int] = [
                        "id" : dataJSON[item]["collaboration_id"].intValue
                    ]
                    Alamofire.request("\(self.url.weburl)/collabrubImages.php", method: .get, parameters: para).responseJSON { (response) in
                        
                        if response.result.isSuccess {
                            
                            let dataJSON1 : JSON = JSON(response.result.value!)
                            // let followers = dataJSON["data"]["counts"]["followed_by"].intValue
//                            print(dataJSON[item])
//                            print(dataJSON1)
                            
                            let localModel = OnlineModel()
                            
                            localModel.announcementImage = dataJSON1[0]["img_url"].stringValue
                            localModel.title = dataJSON[item]["collaboration_name"].stringValue
                            localModel.companyName = dataJSON[item]["company_name"].stringValue
                            localModel.location = dataJSON[item]["address"].stringValue
                            localModel.productImage = [dataJSON1[0]["img_url"].stringValue,dataJSON1[1]["img_url"].stringValue,dataJSON1[2]["img_url"].stringValue]
                            localModel.palceImages = ["",""]
                            localModel.reviews = ["",""]
                            localModel.date = dataJSON[item]["date"].stringValue
                            localModel.description = dataJSON[item]["descriptions"].stringValue
                            localModel.collaborattionTerms = dataJSON[item]["collaboration_terms"].stringValue
                            localModel.avalaibility = ""
                            localModel.selectedNumOfFollowers = dataJSON[item]["followers_limit"].stringValue
                            
                            localModel.collaboration_id = dataJSON[item]["collaboration_id"].stringValue
                            self.model.append(localModel)
                            
                            
                            
                        }else {
                            print("error not get in first")
                        }
                        print("count \(self.model.count)")
                        SVProgressHUD.dismiss()
                        self.collectionView.reloadData()
                        // self.status = true
                    }
                    
                    
                }
                
                
               
                
            }else {
                print("error not get in second")
            }
            
            
        }
        
        
    }

}


extension OnlineAnnouncementViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test1", for: indexPath) as! OnlineAnnouncementCollectionViewCell
        
        cell.imgLocal.sd_setImage(with: URL(string: model[indexPath.row].announcementImage))
        cell.companyName.text = model[indexPath.row].companyName
        cell.announcementTitle.text = model[indexPath.row].title
        cell.location.text = model[indexPath.row].location
        
        
//        cell.layer.cornerRadius = 2.0;
//        cell.layer.borderWidth = 1.0;
//        cell.layer.borderColor = UIColor.clear.cgColor;
//        cell.layer.masksToBounds = true;
//
//        cell.layer.shadowColor = UIColor.gray.cgColor;
//        //        cell.layer.shadowOffset = CGSizeMake(0, 2.0);
//        cell.layer.shadowRadius = 2.0;
//        cell.layer.shadowOpacity = 1.0;
//        cell.layer.masksToBounds = false;
//        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath;
        cell.imgLocal.layer.cornerRadius = 6
        cell.imgLocal.clipsToBounds = true
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
