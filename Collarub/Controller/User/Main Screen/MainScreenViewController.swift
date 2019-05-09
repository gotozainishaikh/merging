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

class MainScreenViewController: UIViewController,UICollectionViewDelegateFlowLayout, PageViewControllerDelegate{
    
    var estimateWidth=130
    var cellMarginSize=5
   
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
    
    var searchBtnArray = ["Food","Sport","Fashion","Beauty","Events","Travel","Digital","Parenting","Home","Automotive","Pets"]
    
    var searchBtnImgArray = ["food.png","sports.png","fashion.png","beauty.png","events.png","travel.png","digital.png","parenting.png","home1.png","driving.png","pets.png"]
    
    
    var pageViewController:PageViewController?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        searchBtnCollectionView.showsHorizontalScrollIndicator = false
        uiNavegationImage()
        //Setup GridView
        self.setupGridView()
        
        let button2 = UIBarButtonItem(image: UIImage(named: "bell-icon"), style: .plain, target: self, action: #selector(actionFavList))
        
        //self.navigationItem.rightBarButtonItem  = button2
        
        
        
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
        
        self.localAnnouncement.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.onlineAnnouncement.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      //  sender.isHighlighted = true
        //sender.backgroundColor = UIColor(named: "themeColor3")
        sender.setTitleColor(UIColor(named: "themecolor4"), for: .normal)
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        onlineAnnouncement.setTitleColor(UIColor(named: "ThemeColor1"), for: .normal)
        onlineAnnouncement.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        pageViewController?.moveToPage(index: 0)
        
    }
    
    
    @IBAction func online(_ sender: UIButton) {
        
        self.localAnnouncement.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.onlineAnnouncement.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
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
    
    func setupGridView(){
        
        let flow = searchBtnCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
        
    }
    
    
}

extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchBtnImgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchBtnCollectionView.dequeueReusableCell(withReuseIdentifier: "searchBtn", for: indexPath) as! CollectionViewCell
        
//        cell.setFilterTabBtn(item: searchBtnArray[indexPath.row])
        cell.setFilterTabBtn(image_item: searchBtnImgArray[indexPath.row],title_item: searchBtnArray[indexPath.row])
        
        cell.tabBtn.tag = indexPath.row
         cell.tabBtn.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
        
        
        return cell
        
    }
    
    
    
    @objc func checkMarkButtonClicked ( sender: UIButton) {
        print("button presed=\((sender.tag))")
//
//        switch sender.currentTitle! {
//
//            case "Food":
//                sender.setImage(UIImage(named: "food-1"), for: .normal)
//
//            case "Sport":
//                sender.setImage(UIImage(named: "sports-1"), for: .normal)
//
//            case "Fashion":
//                sender.setImage(UIImage(named: "fashion-1"), for: .normal)
//
//            case "Beauty":
//                sender.setImage(UIImage(named: "beauty-1"), for: .normal)
//
//            case "Events":
//                 sender.setImage(UIImage(named: "events-1"), for: .normal)
//
//            case "Travel":
//                 sender.setImage(UIImage(named: "travel-1"), for: .normal)
//
//            case "Digital":
//                 sender.setImage(UIImage(named: "digital-1"), for: .normal)
//
//            case "Parenting":
//                 sender.setImage(UIImage(named: "parenting-1"), for: .normal)
//
//            case "Home":
//                 sender.setImage(UIImage(named: "home-1"), for: .normal)
//
//            case "Automotive":
//                 sender.setImage(UIImage(named: "driving-1"), for: .normal)
//
//            case "Pets":
//                 sender.setImage(UIImage(named: "pets-1"), for: .normal)
//
//
//            default:
//                print("default")
//            }

        if sender.isSelected {
            //uncheck the butoon
            sender.isSelected = false
            
        } else {
            // checkmark it
            sender.isSelected = true
            
        }
        
        //self.searchBtnCollectionView.reloadData()
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWidth()
        
        return CGSize(width: width-3, height: 30)
    }
    
    
    func calculateWidth() -> CGFloat{
        
        let screenSize=UIScreen.main.bounds
        //let screenWidth=screenSize.width
        let screenWidth=self.searchBtnCollectionView.frame.size.width
        let estimatedWidth = CGFloat(screenWidth)/3
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
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

