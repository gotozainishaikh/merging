//
//  LocalDetailsViewController.swift
//  Collarub
//
//  Created by Mac 1 on 10/17/1397 AP.
//  Copyright © 1397 Mac 1. All rights reserved.
//

import UIKit
import SDWebImage
import ImageSlideshow
import CoreData

class LocalDetailsViewController: UIViewController {

    let story = UIStoryboard(name: "User", bundle: nil)
    
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
    
    @IBAction func request_btn(_ sender: UIButton) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        var id : String = res.value(forKey: "user_id") as! String
        
        print("coredata_userId=\(id)")
        
        
       
        let vc = story.instantiateViewController(withIdentifier: "pakage") as! PakagePopUPViewController
        vc.user_id = id
       
        
       
        if((detailsArray?.collaboration_id) != nil){
            print("detailsArray=\((detailsArray?.collaboration_id)!)")
            vc.campaign_id = String((detailsArray?.collaboration_id)!)
        }
        else if((modelCustom?.collaboration_id) != nil){
            print("modelCustom=\((modelCustom?.collaboration_id)!)")
            vc.campaign_id = String((modelCustom?.collaboration_id)!)
        }
        
       
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    
    var detailsArray : LocalModel?
    var onlineArray : OnlineModel?
    var statArray : StatusTableModel?
    var modelCustom : customAnnoation?
    var favArray : FavListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
            
            
            //collaborationTerm.text = detailsArray?.collaborattionTerms
            //numOfFollowers.text = detailsArray?.selectedNumOfFollowers
        }
//        else if (onlineArray != nil){
//            image1.sd_setImage(with: URL(string: (onlineArray?.productImage[0])!))
//            image2.sd_setImage(with: URL(string: (onlineArray?.productImage[1])!))
//            image3.sd_setImage(with: URL(string: (onlineArray?.productImage[2])!))
//            advertisementTitle.text = onlineArray?.title
//            companyName.text = onlineArray?.companyName
//            location.text = onlineArray?.location
//            date.text = onlineArray?.date
//            advertisementDescription.text = onlineArray?.description
//            collaborationTerm.text = onlineArray?.collaborattionTerms
//            numOfFollowers.text = onlineArray?.selectedNumOfFollowers
//        }
        else if (modelCustom != nil){
            
            for item in (modelCustom?.productImage)! as [String]{
                if(item != ""){
                    
                    images.append(AlamofireSource(urlString:item)!)
                    
                }
            }
            
            companyName.text = modelCustom?.companyName
            location.text = "\((modelCustom?.required_city)!),\((modelCustom?.required_region)!)"
            date.text = "Date:\((modelCustom?.date)!) "
            expiry_date.text = "Expiry:\((modelCustom?.expiry_date)!)"
            advertisementDescription.text = modelCustom?.description1
            
            if((modelCustom?.type)! == "exchange") || ((modelCustom?.type)! == "Exchange"){
                
                type.text = "EXCHANGE:"
                type_value.text = (modelCustom?.budget_value)!
                
            }
            else if((modelCustom?.type)! == "discount"){
                
                type.text = "DISCOUNT:"
                type_value.text = "\((modelCustom?.budget_value)!) | \((modelCustom?.discount_field)!)"
                
            }
            
            content_type.text = (modelCustom?.content_type)!
            engagement_rate.text = modelCustom?.engagement_rate
            rating.text = (modelCustom?.rating)!
            gender.text = (modelCustom?.user_gender)!
            exp_level.text = "\((modelCustom?.min_user_exp_level)!)/10"
        }
        else if (statArray != nil){
            
          
            print("detailsArray?.productImage=\(statArray?.productImage.count)")
            for item in (statArray?.productImage)! as [String]{
                if(item != ""){
                    
                    images.append(AlamofireSource(urlString:item)!)
                    
                }
            }
            
            companyName.text = statArray?.companyName
            location.text = "\((statArray?.required_city)!),\((statArray?.required_region)!)"
            date.text = "Date:\((statArray?.date)!) "
            expiry_date.text = "Expiry:\((statArray?.expiry_date)!)"
            advertisementDescription.text = statArray?.description
            
            if((statArray?.type)! == "exchange") || ((statArray?.type)! == "Exchange"){
                
                type.text = "EXCHANGE:"
                type_value.text = (statArray?.budget_value)!
                
            }
            else if((statArray?.type)! == "discount"){
                
                type.text = "DISCOUNT:"
                type_value.text = "\((statArray?.budget_value)!) | \((statArray?.discount_field)!)"
                
            }
            
            content_type.text = (statArray?.content_type)!
            engagement_rate.text = statArray?.engagement_rate
            rating.text = (statArray?.rating)!
            gender.text = (statArray?.user_gender)!
            exp_level.text = "\((statArray?.min_user_exp_level)!)/10"
            
            
            //collaborationTerm.text = detailsArray?.collaborattionTerms
            //numOfFollowers.text = detailsArray?.selectedNumOfFollowers
        }
//        else if (favArray != nil) {
//
//            image1.sd_setImage(with: URL(string: (favArray?.productImage[0])!))
//            image2.sd_setImage(with: URL(string: (favArray?.productImage[1])!))
//            image3.sd_setImage(with: URL(string: (favArray?.productImage[2])!))
//            advertisementTitle.text = favArray?.title
//            companyName.text = favArray?.companyName
//            location.text = favArray?.location
//            date.text = favArray?.date
//            advertisementDescription.text = favArray?.description
//            collaborationTerm.text = favArray?.collaborattionTerms
//            numOfFollowers.text = favArray?.selectedNumOfFollowers
//
//        }
        
    }

}

