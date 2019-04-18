//
//  StepViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 12/02/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import JKSteppedProgressBar
import Alamofire
import SwiftyJSON
import SVProgressHUD
import CoreData

class StepViewController: UIViewController, PageViewControllerDelegate,PayPalPaymentDelegate, FlipsideViewControllerDelegate {

    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    var resultText = "" // empty
    var payPalConfig = PayPalConfiguration() // default
    
    
    let story = UIStoryboard(name: "Main", bundle: nil)
    var dict : JSON!
    var data : JSON!
    
    var pageViewController:PageViewController?
     let url = FixVariable()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
    var editing_id : String = ""
    @IBOutlet weak var stepBar: SteppedProgressBar!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var clickBtn: UIButton!
    @IBOutlet weak var savButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //print(pageViewController?.data[38])
        self.pageViewController?.delegate = nil
        self.pageViewController?.dataSource = nil
        stepBar.titles = ["Step","Step","Step","Step","Step"]
        
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Awesome Shirts, Inc."
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .payPal;
        
        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        pageViewController?.editId = editing_id
        if editing_id != "" {
            print("yes id is")
            savButton.isHidden = true
            
            
            let parameters : [String:String] = ["id":editing_id]
            Alamofire.request("\(self.url.weburl)/fetchDraftDetails.php", method: .get, parameters: parameters).responseJSON { (response) in
                
                let dataJSON : JSON = JSON(response.result.value!)
                if response.result.isSuccess {
                    self.pageViewController?.editData = dataJSON
                    
                    self.pageViewController?.editingTable()
                    self.data = dataJSON
                }
                
            }
            Alamofire.request("\(self.url.weburl)/fetchDraftImages.php", method: .get, parameters: parameters).responseJSON { (response) in
                
                let dataJSON : JSON = JSON(response.result.value!)
                if response.result.isSuccess {
                    print(dataJSON)
                    
                    
                }
                
            }
            
            
        }else {
            print("No id")
            savButton.isHidden = false
        }
    }
    
    
    
    @objc func draftList(req_notification: NSNotification) {
        
        var req_id : String = ""
        print("hello")
        if let dict = req_notification.userInfo as NSDictionary? {
            if let id = dict["req_id"] as? String{
                print("id="+id)
                // print("hosp_id="+hosp_id!)
                req_id = id
            }
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

    var arry = [String]()
    var dataArray : [Data] = [Data]()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if let _pageViewController = segue.destination as? PageViewController {
            _pageViewController.viewControllerIdentifiers = ["step1","step2","step3","step4","step5"]
            
            _pageViewController.pageDelegate = self
            
            self.pageViewController = _pageViewController
            
            arry = (pageViewController?.arr)!
            
            
        }
    }
    
    @IBAction func nextBtn(_ sender: UIButton) {
        
        var indx : Int = pageViewController?.currentPageIndex ?? 0
        pageViewController?.moveToPage(index: indx+1)
        
        let currentStep = stepBar.currentTab
        if (currentStep < stepBar.titles.count) {
            if (currentStep == stepBar.titles.count-1){
                
                sender.setTitle("FINISH", for: .normal)
                
               // let stroy = UIStoryboard(name: "Main", bundle: nil)
                
                
              
            }
           
            
            if editing_id != ""{
                let reqDataDict = ["json":self.pageViewController?.editData]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reqreject"), object: nil, userInfo: reqDataDict)
            }
            
            
        stepBar.currentTab = currentStep+1
        }else {
            
            pageViewController?.done()
            let vc1 = story.instantiateViewController(withIdentifier: "errorPop") as? ShowErrorPopViewController
            
            vc1?.model = (pageViewController?.arr)!
            //print(vc1!.model[0])
            
            
            if (pageViewController?.arr.count == 0){
                print("No Error")
                
                resultText = ""
                
                if pageViewController!.isCheck {
                    let test = Double(pageViewController!.val[0]) + Double(pageViewController!.val[1]) + Double(pageViewController!.val[2]) + Double(pageViewController!.val[3]) + Double(pageViewController!.val[4])
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
                }else if !pageViewController!.isCheck {
                    let test = Double(pageViewController!.val[5]) + Double(pageViewController!.val[6]) + Double(pageViewController!.val[7]) + Double(pageViewController!.val[8]) + Double(pageViewController!.val[9])
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
              
                
                
            }
            else {
                print("Error hai")
                print("thisss :: \(pageViewController?.val)")
                print("truue :: \(pageViewController?.isCheck)")
                self.addChild(vc1!)
                self.view.addSubview(vc1!.view)
                vc1!.didMove(toParent: self)
                print("\(pageViewController?.data)")
                
            
//                let countriesArray = NSLocale.isoCountryCodes.map { (code:String) -> String in
//                    let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
//                    let currentLocaleID = NSLocale.current.identifier
//                    return NSLocale(localeIdentifier: currentLocaleID).displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
//                }
//                print("\(countriesArray)")
                
            }
//            let vc = story.instantiateViewController(withIdentifier: "partnerTab")
//            present(vc, animated: true, completion: nil)
//            print("limit reached")
        }
    }
    
    // MARK - Start image service
    
    func requestWith(endUrl: String, imageData: [Data?], parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        // let url = "http://google.com" / your API url /
        
        let headers: HTTPHeaders = [
            
            "Content-type": "multipart/form-data"
        ]
        
        print(endUrl)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            for data in imageData {
                multipartFormData.append(data!, withName: "image[]", fileName: "\((data?.description.prefix(3))!)\(arc4random_uniform(21) + 10).png", mimeType: "image/png")
                print("hello")
            }
            //            if let data = imageData{
            //
            //            }
            
        }, usingThreshold: UInt64.init(), to: endUrl, method: .post, headers: headers) { (result) in
            
            SVProgressHUDStyle.dark
            SVProgressHUD.show(withStatus: "Please Wait")
            switch result{
            case .success(let upload,_,_):
                upload.responseJSON { response in
                    print(response.result.value)
                    SVProgressHUD.dismiss()
                    let vc = self.story.instantiateViewController(withIdentifier: "partnerTab")
                    self.present(vc, animated: true, completion: nil)
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    onCompletion?(nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }
    
    // End service
    
    
    func pageViewController(pageViewController: UIPageViewController, didUpdatePageIndex index: Int) {
        //self.animateBottomBar(index: index)
        print("hello")
        
        UIView.animate(withDuration: 0.2) {
        }
        
        if index == 0 {
          //  changeTab(btn1: localAnnouncement, btn2: onlineAnnouncement)
            
        }else {
         //   changeTab(btn1: onlineAnnouncement, btn2: localAnnouncement)
        }
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        
        clickBtn.setTitle("NEXT", for: .normal)
        var indx : Int = pageViewController?.currentPageIndex ?? 0
        if indx > 0 {
             pageViewController?.moveToPage(index: indx-1)
            
        let currentStep = stepBar.currentTab
            
        if (currentStep > 0 ) {
            
            stepBar.currentTab = currentStep-1
        }else {
            print("exceed")
        }
        }else {
            print("eceeed")
        }
        
    }
    
    
    @IBAction func saveBtn(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Message", message: "Want to save in draft", preferredStyle: .alert)
        
        let save = UIAlertAction(title: "Save", style: .default) { (action) in
            self.pageViewController?.done()
            print(self.pageViewController?.data)
            
            print("\(self.pageViewController?.imageData.count)")
            let results : NSArray = try! self.context.fetch(self.request) as NSArray
            
            let res = results[0] as! NSManagedObject
            
            var id : String = res.value(forKey: "user_id") as! String
            
            let parameters : [String:String] = [
                "collaborationType": (self.pageViewController?.data[0])!,
                "category_name": (self.pageViewController?.data[1])!,
                "type": (self.pageViewController?.data[2])!,
                "accep_budget_check": (self.pageViewController?.data[12])!,
                "budget_value": (self.pageViewController?.data[5])!,
                "discount_field": (self.pageViewController?.data[4])!,
                "content_type": (self.pageViewController?.data[6])!+","+(self.pageViewController?.data[7])!+","+(self.pageViewController?.data[8])!+","+(self.pageViewController?.data[9])!,
                "number_stories": (self.pageViewController?.data[10])!,
                "number_post": (self.pageViewController?.data[11])!,
                "date": (self.pageViewController?.data[13])!,
                "expiry_date": (self.pageViewController?.data[14])!,
                "engagement_rate": (self.pageViewController?.data[15])!,
                "required_city": (self.pageViewController?.data[16])!,
                "required_region": (self.pageViewController?.data[17])!,
                "min_user_rating": (self.pageViewController?.data[18])!,
                "min_user_exp_level": (self.pageViewController?.data[19])!,
                "user_gender": (self.pageViewController?.data[20])!,
                "descriptions": (self.pageViewController?.data[24])!,
                "what_u_offer": (self.pageViewController?.data[25])!,
                "wht_thy_hav_to_do": (self.pageViewController?.data[26])!,
                "wht_wont_hav_to": (self.pageViewController?.data[27])!,
                "e_mail": (self.pageViewController?.data[28])!,
                "phone": (self.pageViewController?.data[29])!,
                "payment_method": (self.pageViewController?.data[36])!,
                "payment_conditions": (self.pageViewController?.data[31])!+"_"+(self.pageViewController?.data[32])!+"_"+(self.pageViewController?.data[33])!+"_"+(self.pageViewController?.data[34])!+"_"+(self.pageViewController?.data[35])!,
                "followers_limit": (self.pageViewController?.data[21])!,
                "collaboration_name": (self.pageViewController?.data[22])!,
                "address": (self.pageViewController?.data[23])!,
                "partner_id": id,
                "lat" : (self.pageViewController?.data[37])!,
                "longg" : (self.pageViewController?.data[38])!
            ]
            let url = "\(self.url.weburl)/draft_images.php"
            print("Parameters :: \(parameters)")
            Alamofire.request("\(self.url.weburl)/draft_data_insert.php", method: .get, parameters: parameters).responseJSON { (response) in
                
                let dataJSON : JSON = JSON(response.result.value!)
                if response.result.isSuccess {
                    print(dataJSON["id"].stringValue)
                    
                    self.requestWith(endUrl: url, imageData: (self.pageViewController?.imageData)!, parameters: ["emp_id" : dataJSON["id"].stringValue])
                }
                
            }

            
        }
        
        let cancel = UIAlertAction(title: "Edit", style: .default) { (cance) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(save)
        alert.addAction(cancel)
    self.present(alert, animated: true, completion: nil)
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
            let results : NSArray = try! self.self.context.fetch(self.request) as NSArray
            
            let res = results[0] as! NSManagedObject
            
            var id : String = res.value(forKey: "user_id") as! String
            
            print("iddddd :: \(id)")
            print("My values \(self.pageViewController?.data)")
            print("\(self.pageViewController?.imageData.count)")
            
            let parameters : [String:String] = [
                "collaborationType": (self.pageViewController?.data[0])!,
                "category_name": (self.pageViewController?.data[1])!,
                "type": (self.pageViewController?.data[2])!,
                "accep_budget_check": (self.pageViewController?.data[12])!,
                "budget_value": (self.pageViewController?.data[5])!,
                "discount_field": (self.pageViewController?.data[4])!,
                "content_type": (self.pageViewController?.data[6])!+","+(self.pageViewController?.data[7])!+","+(self.pageViewController?.data[8])!+","+(self.pageViewController?.data[9])!,
                "number_stories": (self.pageViewController?.data[10])!,
                "number_post": (self.pageViewController?.data[11])!,
                "date": (self.pageViewController?.data[13])!,
                "expiry_date": (self.pageViewController?.data[14])!,
                "engagement_rate": (self.pageViewController?.data[15])!,
                "required_city": (self.pageViewController?.data[16])!,
                "required_region": (self.pageViewController?.data[17])!,
                "min_user_rating": (self.pageViewController?.data[18])!,
                "min_user_exp_level": (self.pageViewController?.data[19])!,
                "user_gender": (self.pageViewController?.data[20])!,
                "descriptions": (self.pageViewController?.data[24])!,
                "what_u_offer": (self.pageViewController?.data[25])!,
                "wht_thy_hav_to_do": (self.pageViewController?.data[26])!,
                "wht_wont_hav_to": (self.pageViewController?.data[27])!,
                "e_mail": (self.pageViewController?.data[28])!,
                "phone": (self.pageViewController?.data[29])!,
                "payment_method": (self.pageViewController?.data[36])!,
                "payment_conditions": (self.pageViewController?.data[31])!+"_"+(self.pageViewController?.data[32])!+"_"+(self.pageViewController?.data[33])!+"_"+(self.pageViewController?.data[34])!+"_"+(self.pageViewController?.data[35])!,
                "followers_limit": (self.pageViewController?.data[21])!,
                "collaboration_name": (self.pageViewController?.data[22])!,
                "address": (self.pageViewController?.data[23])!,
                "partner_id": id,
                "lat" : (self.pageViewController?.data[37])!,
                "longg" : (self.pageViewController?.data[38])!,
                "collab_limit" : (self.pageViewController?.data[39])!,
                "auto_approve" : (self.pageViewController?.data[40])!,
                "coupon_status" : (self.pageViewController?.data[41])!
            ]
            let url = "\(self.url.weburl)/imageUpload.php"
            print("Parameters :: \(parameters)")
            Alamofire.request("\(self.url.weburl)/insert_campaign_data.php", method: .get, parameters: parameters).responseJSON { (response) in
                
                let dataJSON : JSON = JSON(response.result.value!)
                if response.result.isSuccess {
                    print("idies \(dataJSON["id"].stringValue)")
                    
                    self.requestWith(endUrl: url, imageData: (self.pageViewController?.imageData)!, parameters: ["emp_id" : dataJSON["id"].stringValue])
                }
                
            }
           // self.showSuccess()
        })
    }
    
}
