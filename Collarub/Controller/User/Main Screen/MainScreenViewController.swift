//
//  MainScreenViewController.swift
//  Collarub
//
//  Created by Mac 1 on 10/13/1397 AP.
//  Copyright © 1397 Mac 1. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import SVProgressHUD

class MainScreenViewController: UIViewController, PageViewControllerDelegate{
    
    
   
    var ending_soon_chk :String = "0"
    
    let story = UIStoryboard(name: "User", bundle: nil)
    @IBAction func filter_btn(_ sender: UIButton) {
        
        //let stroy = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "filter") as! FilterPopUp
       // vc.user_id = id
        
        
        
//        if((detailsArray?.collaboration_id) != nil){
//            print("detailsArray=\((detailsArray?.collaboration_id)!)")
//            vc.campaign_id = String((detailsArray?.collaboration_id)!)
//        }
//        else if((modelCustom?.collaboration_id) != nil){
//            print("modelCustom=\((modelCustom?.collaboration_id)!)")
//            vc.campaign_id = String((modelCustom?.collaboration_id)!)
//        }
        
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    
    @IBOutlet weak var search_txt: UITextField!
    
  
    
    @IBAction func searchEnd(_ sender: Any) {
       
        print(search_txt.text!)
        
//        let stroy = UIStoryboard(name: "Main", bundle: nil)
//        let vc = stroy.instantiateViewController(withIdentifier: "localAnnouncement") as! LocalAnnouncementViewController
//        vc.text = search_txt.text!
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil, userInfo:["name":search_txt.text!,"type":"local"])
        
    }
    
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var onlineAnnouncement: UIButton!
    @IBOutlet weak var searchBtnCollectionView: UICollectionView!
    
    @IBOutlet weak var localAnnouncement: UIButton!
    
    var searchBtnArray = ["Food","Sport","Fashion","Beauty & HelthCare","Events","Travel","Digital & Devices","Parenting","Home & Decors","Automotive","Pets"]
    
    var searchBtnImgArray = ["Food","Sport","Fashion","Beauty & HelthCare","Events","Travel","Digital & Devices","Parenting","Home & Decors","Automotive","Pets"]
    
    
    var pageViewController:PageViewController?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        searchBtnCollectionView.showsHorizontalScrollIndicator = false
        uiNavegationImage()
        
        let button2 = UIBarButtonItem(image: UIImage(named: "bell-icon"), style: .plain, target: self, action: #selector(actionFavList))
        
        self.navigationItem.rightBarButtonItem  = button2
        
        
        
    }
    

    @IBAction func mapClick(_ sender: UIButton) {
        
        let vc = story.instantiateViewController(withIdentifier: "openMap")
     //   present(vc, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    var items : [UserInformation] = [UserInformation]()
    
    @objc func actionFavList(){
        
        let vc = story.instantiateViewController(withIdentifier: "FavList")
        present(vc, animated: true, completion: nil)
       
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let _pageViewController = segue.destination as? PageViewController {
            _pageViewController.viewControllerIdentifiers = ["localAnnouncement","onlineAnnouncement"]
            _pageViewController.pageDelegate = self
            
            self.pageViewController = _pageViewController
            
            
        }
    }

    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    
    
    @IBAction func local(_ sender: UIButton) {
        
        
      //  sender.isHighlighted = true
        sender.backgroundColor = UIColor(named: "themeColor3")
        sender.setTitleColor(UIColor(named: "themecolor4"), for: .normal)
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        onlineAnnouncement.setTitleColor(UIColor(named: "ThemeColor1"), for: .normal)
        onlineAnnouncement.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        pageViewController?.moveToPage(index: 0)
        
    }
    
    
    @IBAction func online(_ sender: UIButton) {
        pageViewController?.moveToPage(index: 1)
        sender.setTitleColor(UIColor(named: "themecolor4"), for: .normal)
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        localAnnouncement.setTitleColor(UIColor(named: "ThemeColor1"), for: .normal)
        localAnnouncement.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
    }
    
    func changeTab(btn1 : UIButton, btn2 : UIButton){
        btn1.setTitleColor(UIColor(named: "themecolor4"), for: .normal)
        btn1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        btn2.setTitleColor(UIColor(named: "ThemeColor1"), for: .normal)
       btn2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    func pageViewController(pageViewController: UIPageViewController, didUpdatePageIndex index: Int) {
        //self.animateBottomBar(index: index)
        print("hello")
        UIView.animate(withDuration: 0.2) {
        }
        
        if index == 0 {
            changeTab(btn1: localAnnouncement, btn2: onlineAnnouncement)
            
        }else {
            changeTab(btn1: onlineAnnouncement, btn2: localAnnouncement)
        }
        
    }
    
    
}

extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchBtnArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchBtnCollectionView.dequeueReusableCell(withReuseIdentifier: "searchBtn", for: indexPath) as! CollectionViewCell
        
        cell.setFilterTabBtn(item: searchBtnArray[indexPath.row])
//        cell.setFilterTabBtn(item: searchBtnArray[indexPath.row], image: <#T##UIImage#>)
        return cell
        
    }
    
    func setFilterTabBtn(item:String){
        
        //tabBtnItems.setTitle(item, for: .normal)
    }
//
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//
//        switch item.tag  {
//        case 0:
////            searchEngineURLString = "https://www.bing.com"
//            let story = UIStoryboard(name: "Main", bundle: nil)
//            let vc = story.instantiateViewController(withIdentifier: "myview")
//            present(vc, animated: true, completion: nil)
//            print(item.tag)
//            break
//        case 1:
////            searchEngineURLString = "https://www.duckduckgo.com"
//            print(item.tag)
//            break
////        case 2:
////            searchEngineURLString = "https://www.google.com"
////            print(item.tag)
////            break
//        default:
////            searchEngineURLString = "https://www.bing.com"
//            print(item.tag)
//            print("Defaults")
//
//            break
//        }
//    }
    
}

