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

    var inLocl : String = ""
    var inMcro : String = ""
    var inMac : String = ""
    var inMga : String = ""
    var inStr : String = ""
    var pay_method : String = ""
    
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
    
    
    var radioButtonController: SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            
        }
        
        
        inLocal.onClick = { (checked) in
            if checked.isChecked {
                print(self.inLocal.title)
                self.inLocl = self.inLocal.title!
            }else {
                self.inLocl = ""
            }
        }
        
        inMicro.onClick = { (checked) in
            if checked.isChecked {
                print(self.inMicro.title)
                
                self.inMcro = self.inMicro.title!
            }else {
                self.inMcro = ""
            }
        }
        
        inMacro.onClick = { (checked) in
            if checked.isChecked {
                print(self.inMacro.title)
                self.inMac = self.inMacro.title!
            }else {
                self.inMac = ""
            }
        }
        
        inMega.onClick = { (checked) in
            if checked.isChecked {
                print(self.inMega.title)
                self.inMga = self.inMega.title!
            }else {
                self.inMga = ""
            }
        }
        
        inStar.onClick = { (checked) in
            if checked.isChecked {
                print(self.inStar.title)
                self.inStr = self.inStar.title!
            }else {
                self.inStr = ""
            }
        }
        
        caLocal.onClick = { (checked) in
            if checked.isChecked {
                print(self.caLocal.title)
                self.inLocl = self.caLocal.title!
            }else {
                self.inLocl = ""
            }
        }
        
        caMicro.onClick = { (checked) in
            if checked.isChecked {
                print(self.caMicro.title)
                self.inMcro = self.caMicro.title!
            }else {
                self.inMcro = ""
            }
        }
        
        caMacro.onClick = { (checked) in
            if checked.isChecked {
                print(self.caMacro.title)
                self.inMac = self.caMacro.title!
            }else {
                self.inMac = ""
            }
        }
        
        caMega.onClick = { (checked) in
            if checked.isChecked {
                print(self.caMega.title)
                self.inMga = self.caMega.title!
            }else {
                self.inMga = ""
            }
        }
        
        caStar.onClick = { (checked) in
            if checked.isChecked {
                print(self.caStar.title)
                self.inStr = self.caStar.title!
            }else {
                self.inStr = ""
            }
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
            //            payCam = ""
        }else if(selectedButton?.title(for: .normal) == "Pay per campaign"){
            
            payPerInfluencerView.isHidden = true
            payPerCampaignView.isHidden = false
            
            pay_method = (selectedButton?.title(for: .normal))!
            bottomView.isHidden = false
            //            payInflncer = ""
        }
    }
    
    
}
