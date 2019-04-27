//
//  PaymentDropDownViewController.swift
//  Collarub
//
//  Created by mac on 24/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import iOSDropDown
import CoreData
import SVProgressHUD

class PaymentDropDownViewController: UIViewController,PayPalPaymentDelegate, FlipsideViewControllerDelegate {

    var walletValue : Double!
    var api = AlamofireApi()
    var url = FixVariable()
    var partner_id : String!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PartnerRegistration")
    
    
    
     var resultText = "" // empty
    var payPalConfig = PayPalConfiguration() // default
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    @IBOutlet weak var currentBalance: UILabel!
    
    @IBOutlet weak var selectCoins: DropDown!
    @IBOutlet weak var tapView: UIView!
    
    var numCoins : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        getWallet()
        
        
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Awesome Shirts, Inc."
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .payPal;
        
        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
        
        // End
        
        showAnimate()
      
        
        selectCoins.optionArray = ["50", "100", "200", "500", "1000", "2500", "5000"]
        selectCoins.arrowSize = 10
        
        selectCoins.didSelect{(selectedText , index , id) in
              print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            
            self.numCoins = selectedText
            // self.selectedtex = selectedText
        }
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//
//
//
//        tapView.addGestureRecognizer(tap)
//
//
//
//        tapView.isUserInteractionEnabled = true
        
    }
    
//    @objc func handleTap(_ sender: UITapGestureRecognizer) {
//        removeAnimate()
//    }
//
    
    func getWallet(){
        
        let results : NSArray = try! context.fetch(self.request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        partner_id = res.value(forKey: "user_id") as! String
        
            api.alamofireApiWithParams(url: "\(url.weburl)/partner_collab_wallet_info.php", parameters: ["partner_id":partner_id]) { (json) in
                
                self.walletValue = json["wallet"].doubleValue
                
                print("valll :: \(self.walletValue)")
            
                self.currentBalance.text = "Your current balance is \(self.walletValue!)"
        }
        
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }

    @IBAction func cancelAction(_ sender: Any) {
        removeAnimate()
    }
    
    
    @IBAction func endTxt(_ sender: UITextField) {
        print(sender.text!)
        
    }
    @IBAction func txtChng(_ sender: UITextField) {
         print(sender.text!)
        selectCoins.hideList()
        numCoins = sender.text!
    }
    
    
    @IBAction func proceedBtn(_ sender: UIButton) {
        
        print("coins :: \(numCoins)")
        
        if numCoins == ""{
            let alert = UIAlertController(title: "Warning", message: "Please enter your credit", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default) { (ok) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }else {
        if Int(numCoins)! < 50 {
            let alert = UIAlertController(title: "Warning", message: "Your credit must be atleast 50€ or greater", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default) { (ok) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }else {
            
            let item1 = PayPalItem(name: "Paying for collaborup", withQuantity: 1, withPrice:NSDecimalNumber(decimal: Decimal(string: numCoins)!), withCurrency: "EUR", withSku: "Hip-0037")
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
    }
    
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
            var pruchaseCoins : Double = Double(self.numCoins)!
            var totalCoins = pruchaseCoins + self.walletValue
            
            self.api.alamofireApiWithParams(url: "\(self.url.weburl)/update_partner_wallet.php", parameters: ["partner_id":self.partner_id,"amount":"\(totalCoins)"], completion: { (json) in
                
                if json["Status"] == "success"{
                    SVProgressHUD.showSuccess(withStatus: "Wallet Updated")
                    
                }
                
            })
            self.removeAnimate()
            // self.showSuccess()
        })
    }
    
    
}
