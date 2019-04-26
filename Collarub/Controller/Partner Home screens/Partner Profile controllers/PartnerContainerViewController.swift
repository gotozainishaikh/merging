//
//  PartnerContainerViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 02/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import CoreData
import Cosmos
import SDWebImage
import Alamofire
import SwiftyJSON
import SVProgressHUD
import SafariServices

class PartnerContainerViewController: UIViewController {

    
    
    @IBOutlet weak var topHeight: NSLayoutConstraint!
    @IBOutlet weak var buyCredit: UIView!
    @IBOutlet weak var paymentBtn: UIButton!
    @IBOutlet weak var heartView: UIView!
    @IBOutlet weak var switchNotification: UISwitch!
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    @IBOutlet weak var rateNum: UILabel!
    @IBOutlet weak var settingOptionView: UIView!
    @IBOutlet weak var otherOption: UIView!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var engagementRt: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var userImg: UIButton!
    @IBOutlet weak var uparrowimg: UIImageView!
    @IBOutlet weak var heartConstrainst: NSLayoutConstraint!
    
    var p_id = ""
    var userName = ""
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
    var url = FixVariable()
    var api = AlamofireApi()
    var referCode : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        buyCredit.isHidden = true
        switchNotification.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        settingOptionView.isHidden = true

        ratings()
        uiNavegationImage()
        // Do any additional setup after loading the view.
    }
    
    func retriveData(id:String){
        
        let para : [String:String] = ["id" : id]
        Alamofire.request("\(self.url.weburl)/find_partner_engagement_rate.php", method: .get, parameters: para).responseJSON { (response) in
            // SVProgressHUD.show(withStatus: "Connecting to server")
            if response.result.isSuccess {
                
                //   SVProgressHUD.dismiss()
                
                let dataJSON : JSON = JSON(response.result.value!)
                
                if dataJSON["Status"] != "failed" {
                    self.engagementRt.text = "\(dataJSON["engagement"].stringValue)%"
                    
                    let para1 : [String:String] = ["partner_id" : id]
                    Alamofire.request("\(self.url.weburl)/find_partner_level.php", method: .get, parameters: para1).responseJSON { (response) in
                        
                        if response.result.isSuccess {
                            
                            let dataJSON : JSON = JSON(response.result.value!)
                            
                            if dataJSON["Status"] == "success" {
                                self.ratingView.rating = dataJSON["level"].doubleValue
                                self.rateNum.text = "Ratting \(dataJSON["level"].intValue)/5"
                                
                                self.heartConstrainst.constant = 20.0 - CGFloat((dataJSON["level"].doubleValue * 20) / 5)
                            }
                        }
                    }
                }else {
                    self.retriveData(id: id)
                }
            }
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
       
        
            
        
        
        
        if let results : NSArray = try! context.fetch(request) as NSArray {
            let res = results[0] as! NSManagedObject
            
            if let pic : String = res.value(forKey: "profile_picture") as! String {
                userImg.sd_setImage(with: URL(string: pic), for: .normal)
            }
            if let follower : Int64 = res.value(forKey: "followers") as! Int64 {
                followerLabel.text = "\(follower)"
            }
            if let name : String = res.value(forKey: "userName") as! String {
                nameLabel.text = name
                userName = name
            }
            if let id : String = res.value(forKey: "user_id") as! String {
                retriveData(id: id)
                p_id = id
                api.alamofireApiWithParams(url: "\(url.weburl)/find_partner_invitation_value.php", parameters: ["partner_id":p_id]) { (json) in
                    if json["Status"] == "success" {
                        self.referCode = json["refer_code"].stringValue
                    }
                }
            }
        }
        
       
        
        
        
       // print(res.value(forKey: "userName"))
    }
    
    @IBAction func helpBtn(_ sender: Any) {
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "partnerHelp")
        present(vc, animated: true, completion: nil)
        
    }
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    
    
    @IBAction func myReviews(_ sender: UIButton) {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "partnerReview")
        present(vc!, animated: true, completion: nil)
        
        
    }
    @IBAction func top50Btn(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "top50")
        present(vc!, animated: true, completion: nil)
        
    }
    
    
    func ratings(){
        ratingView.settings.updateOnTouch = false
        ratingView.settings.totalStars = 5
        ratingView.settings.fillMode = .precise
//        ratingView.rating = ratingValue
    }
    
    
    
    @IBAction func settingOnclick(_ sender: UIButton) {
        
        if self.settingOptionView.isHidden {
            self.settingOptionView.isHidden = false
            self.topConstraints.constant = 100.0
            uparrowimg.image = UIImage(named: "angle-arrow-down")
        }else {
            self.settingOptionView.isHidden = true
             self.topConstraints.constant = 0.0
            uparrowimg.image = UIImage(named: "up-arrow")
        }
    }
    @IBAction func logoutAction(_ sender: UIButton) {
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                if cookie.domain.contains(".instagram.com") {
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                }
            }
            
            Defaults.setPartnerLoginStatus(logInStatus: false)
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "mainScreen")
            present(vc, animated: true, completion: nil)
            
            deleteAllRecords()
            
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
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    

    @IBAction func notifySwitch(_ sender: UISwitch) {
        if switchNotification.isOn {
            
            let parameters : [String:String] = [
                
                "partner_id": p_id,
                "push_status" : "1"
                
            ]
            
            Alamofire.request("\(self.url.weburl)/update_partner_push_status.php", method: .get, parameters: parameters).responseJSON { (response) in
                SVProgressHUD.show(withStatus: "Loading")
                if response.result.isSuccess {
                    SVProgressHUD.dismiss()
                    let dataJSON1 : JSON = JSON(response.result.value!)
                    
                    if dataJSON1["Status"] == "success" {
                        
                        
                        SVProgressHUD.showSuccess(withStatus: "Done")
                        
                    }
                }
                
            }
        }else {
            let parameters : [String:String] = [
                
                "partner_id": p_id,
                "push_status" : "0"
                
            ]
            
            Alamofire.request("\(self.url.weburl)/update_partner_push_status.php", method: .get, parameters: parameters).responseJSON { (response) in
                SVProgressHUD.show(withStatus: "Loading")
                if response.result.isSuccess {
                    SVProgressHUD.dismiss()
                    let dataJSON1 : JSON = JSON(response.result.value!)
                    
                    if dataJSON1["Status"] == "success" {
                        
                        
                        SVProgressHUD.showSuccess(withStatus: "Done")
                        
                    }
                }
                
            }
        }
    }
    
    
    @IBAction func deleteAccount(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete your account ?", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: .default) { (yes) in
            
            let parameters : [String:String] = [
                
                "userName": self.userName,
                
                ]
            
            Alamofire.request("\(self.url.weburl)/partnerDelete.php", method: .get, parameters: parameters).responseJSON { (response) in
                SVProgressHUD.show(withStatus: "Loading")
                if response.result.isSuccess {
                    SVProgressHUD.dismiss()
                    let dataJSON1 : JSON = JSON(response.result.value!)
                    
                    if dataJSON1["Status"] == "success" {
                        
                        
                        SVProgressHUD.showSuccess(withStatus: "Done")
                        if let cookies = HTTPCookieStorage.shared.cookies {
                            for cookie in cookies {
                                if cookie.domain.contains(".instagram.com") {
                                    HTTPCookieStorage.shared.deleteCookie(cookie)
                                }
                            }
                            
                            Defaults.setPartnerLoginStatus(logInStatus: false)
                            let story = UIStoryboard(name: "Main", bundle: nil)
                            let vc = story.instantiateViewController(withIdentifier: "mainScreen")
                            self.present(vc, animated: true, completion: nil)
                            
                            self.deleteAllRecords()
                            
                        }
                    }
                }
                
            }
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (cancel) in
            alert.dismiss(animated: true, completion: nil)
            
        }
        
        alert.addAction(yes)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func improveInsta(_ sender: Any) {
        
        guard let url = URL(string: "https://influencerskings.com/aziende") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
        
        
    }
   
    
    @IBAction func shareBtn(_ sender: UIButton) {
        let textToShare = "Hello this is invitation code \(referCode) and get amazing discount"
        
        if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
    }
    }
    
    
    @IBAction func company_details(_ sender: UIButton) {
        
        
        let parameters : [String:String] = [
            
            "partner_id": p_id
            
            ]
        
        Alamofire.request("\(self.url.weburl)/check_company_details.php", method: .get, parameters: parameters).responseJSON { (response) in
            SVProgressHUD.show(withStatus: "Loading")
            if response.result.isSuccess {
                SVProgressHUD.dismiss()
                let dataJSON1 : JSON = JSON(response.result.value!)
                
                if dataJSON1["partner_id"] != "" {
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "companydetails") as! CompnayDetailsViewController
                    vc.json = dataJSON1
                    self.present(vc, animated: true, completion: nil)
                    
                    
                    
                    
                    
                    
                }else {
                    
                    
                    var textField = UITextField()
                    var textField1 = UITextField()
                    var textField2 = UITextField()
                    var textField3 = UITextField()
                    var textField4 = UITextField()
                    var textField5 = UITextField()
                    var textField6 = UITextField()
                    
                    let alertController = UIAlertController(title: "Add your company details", message: "", preferredStyle: .alert)
                    alertController.addTextField { (textField : UITextField!) -> Void in
                        textField.placeholder = "Enter Company Name"
                    }
                    alertController.addTextField { (textField : UITextField!) -> Void in
                        textField.placeholder = "Enter Address"
                    }
                    alertController.addTextField { (textField : UITextField!) -> Void in
                        textField.placeholder = "Enter City"
                    }
                    alertController.addTextField { (textField : UITextField!) -> Void in
                        textField.placeholder = "Enter zip code"
                        textField.keyboardType = .numberPad
                    }
                    alertController.addTextField { (textField : UITextField!) -> Void in
                        textField.placeholder = "Enter country"
                    }
                    alertController.addTextField { (textField : UITextField!) -> Void in
                        textField.placeholder = "Enter Vat Number"
                         textField.keyboardType = .numberPad
                    }
                    alertController.addTextField { (textField : UITextField!) -> Void in
                        textField.placeholder = "Enter Invoice Email"
                         textField.keyboardType = .emailAddress
                    }
                    let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
                        let companyNme = alertController.textFields![0] as UITextField
                        let address = alertController.textFields![1] as UITextField
                        let city = alertController.textFields![2] as UITextField
                        let zipCode = alertController.textFields![3] as UITextField
                        let country = alertController.textFields![4] as UITextField
                        let vatNumber = alertController.textFields![5] as UITextField
                        let invoiceEmail = alertController.textFields![6] as UITextField
                        
                        if (companyNme.text == "" || address.text == "" || city.text == "" || zipCode.text == "" || country.text == "" || vatNumber.text == "" || invoiceEmail.text == "" ) {
                            
                            let empAlert = UIAlertController(title: "Warning", message: "Please enter complete details of your company", preferredStyle: .alert)
                            
                            let okay = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                                empAlert.dismiss(animated: true, completion: nil)
                                self.present(alertController, animated: true, completion: nil)
                            })
                            
                            empAlert.addAction(okay)
                            
                            self.present(empAlert, animated: true, completion: nil)
                            
                        }else {
                            
                            let parameters : [String:String] = [
                                
                                "partner_id": self.p_id,
                                "companyNme": companyNme.text!,
                                "address": address.text!,
                                "city": city.text!,
                                "zipCode": zipCode.text!,
                                "country": country.text!,
                                "vatNumber": vatNumber.text!,
                                "invoiceEmail": invoiceEmail.text!
                                
                                ]
                            
                            print("dass :: \(parameters)")
                            
                            Alamofire.request("\(self.url.weburl)/insert_partner_company_details.php", method: .get, parameters: parameters).responseJSON { (response) in
                                SVProgressHUD.show(withStatus: "Loading")
                                if response.result.isSuccess {
                                    SVProgressHUD.dismiss()
                                    let dataJSON5 : JSON = JSON(response.result.value!)
                                    SVProgressHUD.showSuccess(withStatus: "Saved")
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "companydetails") as! CompnayDetailsViewController
                                    vc.json = dataJSON5
                                    self.present(vc, animated: true, completion: nil)
                                  
                                    
                                }
                            }
                            
                            
                            
                            
                        }
                        
                    })
                    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
                    
                    
                    alertController.addAction(saveAction)
                    alertController.addAction(cancelAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
        }
        
        
       
    }
        
    
    @IBAction func payMentAction(_ sender: UIButton) {
        
        if buyCredit.isHidden {
            topHeight.constant = 30.0
            buyCredit.isHidden = false
        }else {
            topHeight.constant = 0
            buyCredit.isHidden = true
            
        }
    }
    
    @IBAction func buyCradit(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "paymentPopUp")
        self.addChild(vc!)
        self.view.addSubview(vc!.view)
        vc!.didMove(toParent: self)
    }
}
