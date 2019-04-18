//
//  DetailsEndedViewController.swift
//  Collarub
//
//  Created by mac on 11/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import SDWebImage
import ImageSlideshow
import CoreData
import Alamofire
import SwiftyJSON


class DetailsEndedViewController: UIViewController {

    var images = [InputSource]()
    
    
    @IBOutlet weak var imgSlider: ImageSlideshow!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var advertisementTitle: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var expiry_date: UILabel!
    
    @IBOutlet weak var type_value: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var advertisementDescription: UILabel!
    @IBOutlet weak var engagement_rate: UILabel!
    
    @IBOutlet weak var content_type: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var exp_level: UILabel!
    
    
    
    @IBOutlet weak var numOfFollowers: UILabel!
    
    @IBOutlet weak var ACCPTBUGT: UIButton!
    
    var url = FixVariable()
    
    var detailsArray : LocalModel?
    var onlineArray : OnlineModel?
    var statArray : StatusTableModel?
    var modelCustom : customAnnoation?
    var favArray : FavListModel?
    var str : [String]!
    var strImg = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("arry :: \(str)")
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imgSlider.addGestureRecognizer(gestureRecognizer)
        
        localDetails()
        
        //Image Silder
        imgSlider.slideshowInterval = 5.0
        imgSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imgSlider.contentScaleMode = UIView.ContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.2156862745, green: 0.6784313725, blue: 0.5882352941, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        imgSlider.pageIndicator = pageControl
        
        
        
        
        imgSlider.setImageInputs(images)
        
        
        
        
        
        ACCPTBUGT.layer.borderColor = UIColor(named: "themecolor4")?.cgColor
        ACCPTBUGT.layer.borderWidth = 0.5
        uiNavegationImage()
        //print("description=\((detailsArray?.description)!)")
        //     UINavigationBar.appearance().tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        // Do any additional setup after loading the view.
        
      
    }
    
    
    @objc func didTap() {
        imgSlider.presentFullScreenController(from: self)
    }
    
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    
    
    func detail(array:[AnyClass]){
        
    }
    
    func localDetails(){
        
        
        if (detailsArray != nil) {
            
            //            image1.sd_setImage(with: URL(string: (detailsArray?.productImage[0])!))
            //            image2.sd_setImage(with: URL(string: (detailsArray?.productImage[1])!))
            //            image3.sd_setImage(with: URL(string: (detailsArray?.productImage[2])!))
            //advertisementTitle.text = detailsArray?.title
            print("detailsArray?.productImage=\(detailsArray?.productImage.count)")
            for item in (detailsArray?.productImage)! as [String]{
                if(item != ""){
                    
                    images.append(AlamofireSource(urlString:item)!)
                    
                }
            }
            
            companyName.text = detailsArray?.companyName
            location.text = "\((detailsArray?.required_city)!),\((detailsArray?.required_region)!)"
            date.text = "Date:\((detailsArray?.date)!) "
            expiry_date.text = "Expiry:\((detailsArray?.expiry_date)!)"
            advertisementDescription.text = detailsArray?.description
            
            if((detailsArray?.type)! == "exchange") || ((detailsArray?.type)! == "Exchange"){
                
                type.text = "EXCHANGE:"
                type_value.text = (detailsArray?.budget_value)!
                
            }
            else if((detailsArray?.type)! == "discount"){
                
                type.text = "DISCOUNT:"
                type_value.text = "\((detailsArray?.budget_value)!) | \((detailsArray?.discount_field)!)"
                
            }
            
            content_type.text = (detailsArray?.content_type)!
            engagement_rate.text = detailsArray?.engagement_rate
            rating.text = (detailsArray?.rating)!
            gender.text = (detailsArray?.user_gender)!
            exp_level.text = "\((detailsArray?.min_user_exp_level)!)/10"
        
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func influencerBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "history") as! CompletedHistoryViewController
        vc.isCheck = true
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func duplicateCampaign(_ sender: UIButton) {
        
        print("duplicate :: \(detailsArray?.partner_id)")
        
        let parameters : [String:String] = [
            "collaborationType": (detailsArray?.collaborationType)!,
            "category_name": (detailsArray?.category_name)!,
            "type": (detailsArray?.type)!,
            "accep_budget_check": (detailsArray?.Accep_budget_check)!,
            "budget_value": (detailsArray?.budget_value)!,
            "discount_field": (detailsArray?.discount_field)!,
            "content_type": (detailsArray?.content_type)!,
            "number_stories": (detailsArray?.number_stories)!,
            "number_post": (detailsArray?.number_post)!,
            "date": (detailsArray?.date)!,
            "expiry_date": (detailsArray?.expiry_date)!,
            "engagement_rate": (detailsArray?.engagement_rate)!,
            "required_city": (detailsArray?.required_city)!,
            "required_region": (detailsArray?.required_region)!,
            "min_user_rating": (detailsArray?.rating)!,
            "min_user_exp_level": (detailsArray?.min_user_exp_level)!,
            "user_gender": (detailsArray?.user_gender)!,
            "descriptions": (detailsArray?.description)!,
            "what_u_offer": (detailsArray?.what_u_offer)!,
            "wht_thy_hav_to_do": (detailsArray?.wht_thy_hav_to_do)!,
            "wht_wont_hav_to": (detailsArray?.wht_wont_hav_to)!,
            "e_mail": (detailsArray?.e_mail)!,
            "phone": (detailsArray?.phone)!,
            "payment_method": str[0],
            "payment_conditions": "\(str[1])_\(str[2])_\(str[3])_\(str[4])_\(str[5])",
            "followers_limit": (detailsArray?.selectedNumOfFollowers)!,
            "collaboration_name": (detailsArray?.title)!,
            "address": (detailsArray?.location)!,
            "partner_id": (detailsArray?.partner_id)!,
            "lat" : "\((detailsArray?.lat)!)",
            "longg" : "\((detailsArray?.long)!)",
            "collab_limit" : str[8],
            "auto_approve" : str[7],
            "coupon_status" : str[6]
        ]
        let url = "\(self.url.weburl)/imageUpload.php"
        print("Parameters :: \(parameters)")
        Alamofire.request("\(self.url.weburl)/insert_campaign_data.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            let dataJSON : JSON = JSON(response.result.value!)
            if response.result.isSuccess {
                print("idies \(dataJSON["id"].stringValue)")
                
                //fetch images
                let para : [String:String] = ["id":(self.detailsArray?.collaboration_id)!]
                Alamofire.request("\(self.url.weburl)/collabrubImages.php", method: .get, parameters: para).responseJSON { (response) in
                    
                    let dataJSON1 : JSON = JSON(response.result.value!)
                    if response.result.isSuccess {
                        
                        print("images :: \(dataJSON1.count)")
                        
                        for item in 0..<dataJSON1.count {
                            print(dataJSON1[item]["img_url"].stringValue)
                            
                            Alamofire.request("\(self.url.weburl)/repeatCampaignImages.php?col_id=\(dataJSON["id"].stringValue)&imageurl=\(dataJSON1[item]["img_url"].stringValue)", method: .get).responseJSON { (response) in
                                
                                let dataJSON2 : JSON = JSON(response.result.value!)
                                if response.result.isSuccess {
                                    
                                    print(dataJSON2)
                                }
                            }
                        }
                        
                        
                    }
                    
                }
                
                let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "partnerTab") as! PartnerTabBarController
                
                mainTabController.selectedViewController = mainTabController.viewControllers?[0]
                self.present(mainTabController, animated: true, completion: nil)
                
            }
            
            
        }
    }
    
}
