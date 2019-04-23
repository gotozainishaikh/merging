//
//  PayPal.swift
//  Collarub
//
//  Created by apple on 20/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class PayPal: UIViewController,PayPalPaymentDelegate {

    @IBOutlet weak var plan: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var pay_btn: UIButton!
    
    let story = UIStoryboard(name: "User", bundle: nil)
    var plan_price : Double!
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
   
    var payPalConfig = PayPalConfiguration() // default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        if(plan_price==499){
            plan.text = "1 Month"
            tagline.text = "Unlimited Collaborations for 1 Month"
            pay_btn.setTitle("Pay 4,99 €", for: .normal)
            
        }
        else if(plan_price==2245){
            plan.text = "6 Month"
            tagline.text = "Unlimited Collaborations for 6 Month"
             pay_btn.setTitle("Pay 22,45 €", for: .normal)
            
        }
        else if(plan_price==3592){
            plan.text = "1 Year"
            tagline.text = "Unlimited Collaborations for 1 Year"
             pay_btn.setTitle("Pay 35,92 €", for: .normal)
            
        }
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Awesome Shirts, Inc."
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .payPal;
        
        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
//        var environment:String = PayPalEnvironmentNoNetwork {
//            willSet(newEnvironment) {
//                if (newEnvironment != environment) {
//                    PayPalMobile.preconnect(withEnvironment: newEnvironment)
//                }
//            }
//        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func payPal_btn(_ sender: UIButton) {
        
        print("paypal")
        
        
//        let vc = story.instantiateViewController(withIdentifier: "pakage")
//
//        self.addChild(vc)
//        self.view.addSubview(vc.view)
//        vc.didMove(toParent: self)
//
//            let test = Double(val[0]) + Double(val[1]) + Double(val[2]) + Double(val[3]) + Double(val[4])
//            //let test = self(rawValue: self.RawValue(val[0]))+val[1]+val[2]
//            print(test)
        
            let item1 = PayPalItem(name: "Paying for collaborup", withQuantity: 1, withPrice:NSDecimalNumber(decimal: Decimal(plan_price)), withCurrency: "EUR", withSku: "Hip-0037")
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
    
    
    @IBAction func cancel(_ sender: UIButton) {
    
        removeAnimate()
//        let vc = story.instantiateViewController(withIdentifier: "myPro")
//
//
//
//        present(vc, animated: true, completion: nil)
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
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        
        //successView.isHidden = true
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            self.removeAnimate()
         
        })
    }
    
}
