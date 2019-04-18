//
//  step5endedViewController.swift
//  Collarub
//
//  Created by mac on 06/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import CheckBox
import iOSDropDown
import SwiftyJSON

class step5endedViewController: UIViewController,SSRadioButtonControllerDelegate {

    var model = LocalModel()
    var inLocl : String = ""
    var inMcro : String = ""
    var inMac : String = ""
    var inMga : String = ""
    var inStr : String = ""
    var pay_method : String = ""
    var limt : String = ""
    var copon : String = ""
    var autoaprv : String = "0"
    
    var str : [String]!
    var val : [NSDecimalNumber]!
    
    @IBOutlet weak var autoApprvCheck: CheckBox!
    @IBOutlet weak var blockCheck: CheckBox!
    @IBOutlet weak var payBtn1: UIButton!
    @IBOutlet weak var payBtn2: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var payPerInfluencerView: UIView!
    @IBOutlet weak var payPerCampaignView: UIView!
    @IBOutlet weak var btmconstraints: NSLayoutConstraint!
    
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
    
    
    var payloc : NSDecimalNumber = 0.0
    var payMicro : NSDecimalNumber = 0.0
    var payMacro : NSDecimalNumber = 0.0
    var payMega : NSDecimalNumber = 0.0
    var payStar : NSDecimalNumber = 0.0
    
    var pay1loc : NSDecimalNumber = 0.0
    var pay1Micro : NSDecimalNumber = 0.0
    var pay1Macro : NSDecimalNumber = 0.0
    var pay1Mega : NSDecimalNumber = 0.0
    var pay1Star : NSDecimalNumber = 0.0
    
    var isCheck : Bool!
    
    var radioButtonController: SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("data :: \(model.collaboration_id)")
        //bottomView.isHidden = true
        
        
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
        
        autoApprvCheck.onClick = { (checked) in
            if checked.isChecked {
                
                self.autoaprv = "1"
            }else {
                self.autoaprv = "0"
            }
        }
        
        blockCheck.onClick = { (checked) in
            if checked.isChecked {
                
                self.copon = "1"
            }else {
                self.copon = "0"
            }
        }

        
        inLocal.onClick = { (checked) in
            if checked.isChecked {
                print("yes \(self.inLocal.title)")
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
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func nextClick(_ sender: UIButton) {
        
        if pay_method == "" {
            alert(title: "Alert", messg: "Select Payment Method")
        }else if (inLocl == "" && inMcro == "" && inMac == "" && inMga == "" && inStr == "" ) {
            alert(title: "Alert", messg: "Select one payment condition")
        }else {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "allDetails") as! DetailsEndedViewController
        str = [pay_method,inLocl,inMcro,inMac,inMga,inStr,copon,autoaprv,limt]
            val = [payloc,payMicro,payMacro,payMega,payStar,pay1loc,pay1Micro,pay1Macro,pay1Mega,pay1Star]
        vc.detailsArray = model
        vc.str = str!
            vc.val = val
            vc.isCheck = isCheck
        present(vc, animated: true, completion: nil)
        
    }
    }
    func didSelectButton(selectedButton: UIButton?)
    {
        print(" \(selectedButton?.title(for: .normal))" )
        
        if (selectedButton?.title(for: .normal) == "Pay per influencer"){
            payPerInfluencerView.isHidden = false
            payPerCampaignView.isHidden = true
            bottomView.isHidden = false
            btmconstraints.constant = -12
            pay_method = (selectedButton?.title(for: .normal))!
            isCheck = true
            print(isCheck)
            //            payCam = ""
        }else if(selectedButton?.title(for: .normal) == "Pay per campaign"){
            
            payPerInfluencerView.isHidden = true
            payPerCampaignView.isHidden = false
            bottomView.isHidden = false
            btmconstraints.constant = -12
            
            pay_method = (selectedButton?.title(for: .normal))!
            bottomView.isHidden = false
            isCheck = false
            print(isCheck)
            //            payInflncer = ""
        }
    }
    
    func alert(title:String,messg:String){
        
        let alert = UIAlertController(title: title, message: messg, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style:.default) { (ok) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
}
