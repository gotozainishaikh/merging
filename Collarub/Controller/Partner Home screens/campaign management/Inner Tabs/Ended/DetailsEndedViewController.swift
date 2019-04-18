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
import SVProgressHUD


class DetailsEndedViewController: UIViewController,PayPalPaymentDelegate, FlipsideViewControllerDelegate {

    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    var images = [InputSource]()
    
    var resultText = "" // empty
    var payPalConfig = PayPalConfiguration() // default
    
    
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
    var val : [NSDecimalNumber]!
    var isCheck : Bool!
    var strImg = String()
    
    
    override func viewWillAppear(_ animated: Bool) {
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Awesome Shirts, Inc."
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .payPal;
        
        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
        
        if isCheck {
            print("here :: \(val[0]), \(val[1]), \(val[2]), \(val[3]), \(val[4])")
        }else if !isCheck {
            print("\(val[5]), \(val[6]), \(val[7]), \(val[8]), \(val[9])")
        }
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
        
        resultText = ""
        
        if isCheck {
            let test = Double(val[0]) + Double(val[1]) + Double(val[2]) + Double(val[3]) + Double(val[4])
                //let test = self(rawValue: self.RawValue(val[0]))+val[1]+val[2]
                print(test)
            
            let item1 = PayPalItem(name: "Paying for collaborup", withQuantity: 1, withPrice:NSDecimalNumber(decimal: Decimal(test)), withCurrency: "EUR", withSku: "Hip-0037")
            let items = [item1]
            
            let subtotal = PayPalItem.totalPrice(forItems: items)
            
            let payment = PayPalPayment(amount: subtotal, currencyCode: "EUR", shortDescription: "Paying for collaborup", intent: .sale)
            payment.items = items
            
            
            if (payment.processable) {
                print("Payment not processalbe: \(payment)")
                let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
                present(paymentViewController!, animated: true, completion: nil)
            }
            else {
                // This particular payment will always be processable. If, for
                // example, the amount was negative or the shortDescription was
                // empty, this payment wouldn't be processable, and you'd want
                // to handle that here.
                print("Payment not processalbe: \(payment)")
            }
        }else if !isCheck {
            let test = Double(val[5]) + Double(val[6]) + Double(val[7]) + Double(val[8]) + Double(val[9])
                //let test = self(rawValue: self.RawValue(val[0]))+val[1]+val[2]
                print(test)
            
            let item1 = PayPalItem(name: "Paying for collaborup", withQuantity: 1, withPrice:NSDecimalNumber(decimal: Decimal(test)), withCurrency: "EUR", withSku: "Hip-0037")
            let items = [item1]
            
            let subtotal = PayPalItem.totalPrice(forItems: items)
            
            let payment = PayPalPayment(amount: subtotal, currencyCode: "EUR", shortDescription: "Paying for collaborup", intent: .sale)
            payment.items = items
            
            
            if (payment.processable) {
                print("Payment not processalbe: \(payment)")
                let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
                present(paymentViewController!, animated: true, completion: nil)
            }
            else {
                // This particular payment will always be processable. If, for
                // example, the amount was negative or the shortDescription was
                // empty, this payment wouldn't be processable, and you'd want
                // to handle that here.
                print("Payment not processalbe: \(payment)")
            }
        }
       

        
//        if isCheck {
//
//            let item1 = PayPalItem(name: "Paying for collaborup", withQuantity: 1, withPrice: , withCurrency: "EUR", withSku: "")
//
//            
//
//            let items = [item1]
//        }
//
        
        

    }
    
    
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        resultText = ""
        //successView.isHidden = true
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            
            self.resultText = completedPayment.description
            
                    let parameters : [String:String] = [
                        "collaborationType": (self.detailsArray?.collaborationType)!,
                        "category_name": (self.detailsArray?.category_name)!,
                        "type": (self.detailsArray?.type)!,
                        "accep_budget_check": (self.detailsArray?.Accep_budget_check)!,
                        "budget_value": (self.detailsArray?.budget_value)!,
                        "discount_field": (self.detailsArray?.discount_field)!,
                        "content_type": (self.detailsArray?.content_type)!,
                        "number_stories": (self.detailsArray?.number_stories)!,
                        "number_post": (self.detailsArray?.number_post)!,
                        "date": (self.detailsArray?.date)!,
                        "expiry_date": (self.detailsArray?.expiry_date)!,
                        "engagement_rate": (self.detailsArray?.engagement_rate)!,
                        "required_city": (self.detailsArray?.required_city)!,
                        "required_region": (self.detailsArray?.required_region)!,
                        "min_user_rating": (self.detailsArray?.rating)!,
                        "min_user_exp_level": (self.detailsArray?.min_user_exp_level)!,
                        "user_gender": (self.detailsArray?.user_gender)!,
                        "descriptions": (self.detailsArray?.description)!,
                        "what_u_offer": (self.detailsArray?.what_u_offer)!,
                        "wht_thy_hav_to_do": (self.detailsArray?.wht_thy_hav_to_do)!,
                        "wht_wont_hav_to": (self.detailsArray?.wht_wont_hav_to)!,
                        "e_mail": (self.detailsArray?.e_mail)!,
                        "phone": (self.detailsArray?.phone)!,
                        "payment_method": self.str[0],
                        "payment_conditions": "\(self.str[1])_\(self.str[2])_\(self.str[3])_\(self.str[4])_\(self.str[5])",
                        "followers_limit": (self.detailsArray?.selectedNumOfFollowers)!,
                        "collaboration_name": (self.detailsArray?.title)!,
                        "address": (self.detailsArray?.location)!,
                        "partner_id": (self.detailsArray?.partner_id)!,
                        "lat" : "\((self.detailsArray?.lat)!)",
                        "longg" : "\((self.detailsArray?.long)!)",
                        "collab_limit" : self.str[8],
                        "auto_approve" : self.str[7],
                        "coupon_status" : self.str[6]
                    ]
            
            SVProgressHUD.show()
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
                            
                            SVProgressHUD.dismiss()
            
                            let mainTabController = self.storyboard?.instantiateViewController(withIdentifier: "partnerTab") as! PartnerTabBarController
            
                            mainTabController.selectedViewController = mainTabController.viewControllers?[0]
                            self.present(mainTabController, animated: true, completion: nil)
            
                        }
            
            
                    }
            //self.showSuccess()
        })
    }
    
}
