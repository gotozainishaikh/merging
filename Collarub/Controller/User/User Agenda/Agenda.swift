//
//  Agenda.swift
//  Collarub
//
//  Created by apple on 05/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import SVProgressHUD
import ImageSlideshow
import CoreData

class Agenda: UIViewController{
    
    @IBOutlet weak var partner_name: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    var col_id : String = ""
    var partner_id : String = ""
    
    
    var model : [AgendaModel] = [AgendaModel]()
    
    var statArray : StatusTableModel?
    
    let url = FixVariable()
    
    var images = [InputSource]()
    
    
    @IBOutlet weak var imgSlider: ImageSlideshow!
    

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
    
    
    
    //@IBOutlet weak var numOfFollowers: UILabel!
    
    @IBOutlet weak var ACCPTBUGT: UIButton!
    
    
    
    
    var detailsArray : LocalModel?
    var onlineArray : OnlineModel?
    //var statArray : StatusTableModel?
    var modelCustom : customAnnoation?
    var favArray : FavListModel?
    
    
    @IBAction func complete_btn(_ sender: UIButton) {
        
        let stroy = UIStoryboard(name: "Main", bundle: nil)
        let vc = stroy.instantiateViewController(withIdentifier: "complete_popup") 
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        localDetails()
        
        print("col_id=\(col_id)")
        print("partner_id=\(partner_id)")
        retriveData(partner_id: partner_id, collaboration_id: col_id){
            
            
            self.partner_name.text =
            "Partner Username: \(self.model[0].partner_username)"
            self.address.text =
            "Address: \(self.model[0].col_address)"
            self.phone.text =
            "Telephone: \(self.model[0].col_phone)"
            self.email.text =
            "Email: \(self.model[0].col_e_mail)"
            
        }
        
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
            col_id = (statArray?.collaboration_id)!
            partner_id = (statArray?.partner_id)!
            
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
    
    func retriveData(partner_id: String, collaboration_id:String, completion: @escaping () -> Void){
        
        let para : [String:String] = [
            "partner_id": partner_id,
            "collaboration_id": collaboration_id
            
        ]
        print("partner_id=\(partner_id)")
        print("collaboration_id=\(collaboration_id)")
        
        
        Alamofire.request("\(self.url.weburl)/get_user_agenda_details.php", method: .get, parameters: para).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let dataJSON : JSON = JSON(response.result.value!)
                
                let agendaModel = AgendaModel()
                
                
                
                agendaModel.partner_username = dataJSON[0]["partner_username"].stringValue
                agendaModel.col_address = dataJSON[0]["address"].stringValue
                agendaModel.col_phone = dataJSON[0]["phone"].stringValue
                agendaModel.col_e_mail = dataJSON[0]["e_mail"].stringValue
                
                self.model.append(agendaModel)
                
                //   SVProgressHUD.dismiss()
                
            }else {
                print("error not get in first")
            }
            completion()
            //print("count \(self.model[0].partner_username)")
            
            
            
        }
        
    }
    
}
