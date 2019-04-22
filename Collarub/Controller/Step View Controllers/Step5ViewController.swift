//
//  Step5ViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 16/02/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import CheckBox
import iOSDropDown
import SwiftyJSON

class Step5ViewController: UIViewController,SSRadioButtonControllerDelegate {

    var inLocl : String = ""
    var inMcro : String = ""
    var inMac : String = ""
    var inMga : String = ""
    var inStr : String = ""
    var caLocl : String = ""
    var caMcro : String = ""
    var caMac : String = ""
    var caMga : String = ""
    var caStr : String = ""
    var payInflncer : String = ""
    var payCam : String = ""
    var pay_method : String = ""
    var limt : String = ""
    var copon : String = ""
    var autoaprv : String = "0"
    
    
    var val : [NSDecimalNumber]!
    var payloc : NSDecimalNumber = 0.0
    var payMicro : NSDecimalNumber = 0.0
    var payMacro : NSDecimalNumber = 0.0
    var payMega : NSDecimalNumber = 0.0
    var payStar : NSDecimalNumber = 0.0
    
    @IBOutlet weak var haveCouponField: UITextField!
    var pay1loc : NSDecimalNumber = 0.0
    var pay1Micro : NSDecimalNumber = 0.0
    var pay1Macro : NSDecimalNumber = 0.0
    var pay1Mega : NSDecimalNumber = 0.0
    var pay1Star : NSDecimalNumber = 0.0
    
    var isCheck : Bool!
    
    @IBOutlet weak var autoapprv: CheckBox!
    @IBOutlet weak var coupon: CheckBox!
    @IBOutlet weak var payBtn1: UIButton!
    @IBOutlet weak var payBtn2: UIButton!
   
    @IBOutlet weak var payPerInfluencerView: UIView!
    @IBOutlet weak var payPerCampaignView: UIView!
    
    @IBOutlet weak var btmconstrainsts: NSLayoutConstraint!
    
    @IBOutlet weak var limitinfluencer: DropDown!
    @IBOutlet weak var inLocal: CheckBox!
    @IBOutlet weak var inMicro: CheckBox!
    @IBOutlet weak var inMacro: CheckBox!
    @IBOutlet weak var inMega: CheckBox!
    @IBOutlet weak var inStar: CheckBox!
    
    
    @IBOutlet weak var caLocal: CheckBox!
    @IBOutlet weak var caMicro: CheckBox!
    @IBOutlet weak var caMacro: CheckBox!
    @IBOutlet weak var caMega: CheckBox!
    @IBOutlet weak var caStar: CheckBox!
    
    var radioButtonController: SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        haveCouponField.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(rejectList(req_notification:)), name: NSNotification.Name(rawValue: "reqreject"), object: nil)

        //MARK - radio button
        radioButtonController = SSRadioButtonsController(buttons: payBtn1,payBtn2)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        limitinfluencer.optionArray = ["300", "400", "500","600"]
        
        payPerInfluencerView.isHidden = true
        payPerCampaignView.isHidden = true
        limitinfluencer.didSelect{(selectedText , index , id) in
            //            print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            self.limt = selectedText
        }
        
        
        autoapprv.onClick = { (checked) in
            if checked.isChecked {
                print(self.autoapprv.title)
                self.autoaprv = "1"
            }else {
                self.autoaprv = "0"
            }
        }
        
        coupon.onClick = { (checked) in
            if checked.isChecked {
                print(self.coupon.title)
                self.copon = "1"
                self.haveCouponField.isHidden = false
            }else {
                self.copon = "0"
                self.haveCouponField.isHidden = true
            }
        }
        
        inLocal.onClick = { (checked) in
            if checked.isChecked {
                print(self.inLocal.title)
                self.inLocl = self.inLocal.title!
                self.payloc = 199.0
            }else {
                self.inLocl = ""
                  self.payloc = 0.0
            }
        }
        
        inMicro.onClick = { (checked) in
            if checked.isChecked {
                print(self.inMicro.title)
                
                self.inMcro = self.inMicro.title!
                self.payMicro = 499.0
            }else {
                self.inMcro = ""
                self.payMicro = 0.0
            }
        }
        
        inMacro.onClick = { (checked) in
            if checked.isChecked {
                print(self.inMacro.title)
                self.inMac = self.inMacro.title!
                self.payMacro = 1999.0
            }else {
                 self.inMac = ""
                self.payMacro = 0.0
            }
        }
        
        inMega.onClick = { (checked) in
            if checked.isChecked {
                print(self.inMega.title)
                self.inMga = self.inMega.title!
                self.payMega = 2999.0
            }else {
                self.inMga = ""
                self.payMega = 0.0
            }
        }
        
        inStar.onClick = { (checked) in
            if checked.isChecked {
                print(self.inStar.title)
                self.inStr = self.inStar.title!
                self.payStar = 3999.0
            }else {
                self.inStr = ""
                self.payStar = 0.0
            }
        }
        
        caLocal.onClick = { (checked) in
            if checked.isChecked {
                print(self.caLocal.title)
                self.inLocl = self.caLocal.title!
                self.pay1loc = 19.0
            }else {
                self.inLocl = ""
                self.pay1loc = 0.0
            }
        }
        
        caMicro.onClick = { (checked) in
            if checked.isChecked {
                print(self.caMicro.title)
                self.inMcro = self.caMicro.title!
                self.pay1Micro = 39.0
            }else {
                self.inMcro = ""
                self.pay1Micro = 0.0
            }
        }
        
        caMacro.onClick = { (checked) in
            if checked.isChecked {
                print(self.caMacro.title)
                self.inMac = self.caMacro.title!
                self.pay1Macro = 89.0
            }else {
                 self.inMac = ""
                self.pay1Macro = 0.0
            }
        }
        
        caMega.onClick = { (checked) in
            if checked.isChecked {
                print(self.caMega.title)
                self.inMga = self.caMega.title!
                self.pay1Mega = 149.0
            }else {
                self.inMga = ""
                self.pay1Mega = 0.0
            }
        }
        
        caStar.onClick = { (checked) in
            if checked.isChecked {
                print(self.caStar.title)
                self.inStr = self.caStar.title!
                self.pay1Star = 299.0
            }else {
                self.inStr = ""
                self.pay1Star = 0.0
            }
        }
        

        
    }
    
    
    @objc func rejectList(req_notification: NSNotification) {
        var req_id : String = ""
        
        if let dict = req_notification.userInfo as NSDictionary? {
            if let id = dict["json"] as? JSON{
                print("id zain :::: \(id[0]["payment_method"])")
                
                if let pay = id[0]["payment_method"].stringValue as? String {
                    if pay != ""{
                        if pay == "Pay per influencer" {
                            pay_method = pay
                            radioButtonController?.pressed(payBtn1)
                            payPerInfluencerView.isHidden = false
                            payPerCampaignView.isHidden = true
                        }else if pay == "Pay per campaign" {
                            pay_method = pay
                             radioButtonController?.pressed(payBtn2)
                            payPerInfluencerView.isHidden = true
                            payPerCampaignView.isHidden = false
                        }
                    }
                }
                
                if let payTyp = id[0]["content_type"].stringValue as? String {
                    print(payTyp)
                    let addressStrin = id[0]["payment_conditions"].stringValue.components(separatedBy: "_")
                    for item in 0..<addressStrin.count {
                        print("zain :: \(addressStrin[item])")
                        if addressStrin[item] == "Local (1k-15k) 1,99€" {
                            inLocal.isChecked = true
                            inLocl = addressStrin[item]
                            
                        }
                        if addressStrin[item] == "Micro (15k-100k) 4,99€" {
                            inMicro.isChecked = true
                            inMcro = addressStrin[item]
                        }
                        if addressStrin[item] == "Macro (100k-500k) 19,99€" {
                            inMacro.isChecked = true
                            inMac = addressStrin[item]
                        }
                        if addressStrin[item] == "Mega (500k-1mln) 29,99€" {
                            inMega.isChecked = true
                            inMga = addressStrin[item]
                        }
                        if addressStrin[item] == "Star (+1mln) 39,99€" {
                            inStar.isChecked = true
                            inStr = addressStrin[item]
                        }
                        
                        if addressStrin[item] == "Local (1k-15k) 19€" {
                            caLocal.isChecked = true
                            inLocl = addressStrin[item]
                            
                        }
                        if addressStrin[item] == "Micro (15k-100k) 39€" {
                            caMicro.isChecked = true
                            inMcro = addressStrin[item]
                        }
                        if addressStrin[item] == "Macro (100k-500k) 89€" {
                            caMacro.isChecked = true
                            inMac = addressStrin[item]
                        }
                        if addressStrin[item] == "Mega (500k-1mln) 149€" {
                            caMega.isChecked = true
                            inMga = addressStrin[item]
                        }
                        if addressStrin[item] == "Star (+1mln) 299€" {
                            caStar.isChecked = true
                            inStr = addressStrin[item]
                        }
                        
                        
                        
                    }
                    
                    
                }
                
                
                
            }
        }
    }
    
    func didSelectButton(selectedButton: UIButton?)
    {
        print(" \(selectedButton?.title(for: .normal))" )
        
        if (selectedButton?.title(for: .normal) == "Pay per influencer"){
            payPerInfluencerView.isHidden = false
            payPerCampaignView.isHidden = true
            btmconstrainsts.constant = 5
            pay_method = (selectedButton?.title(for: .normal))!
//            payCam = ""
             isCheck = true
        }else if(selectedButton?.title(for: .normal) == "Pay per campaign"){
            
            payPerInfluencerView.isHidden = true
            payPerCampaignView.isHidden = false
            btmconstrainsts.constant = 5
            pay_method = (selectedButton?.title(for: .normal))!
            isCheck = false
//            payInflncer = ""
        }
    }
}
