//
//  Step2ViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 15/02/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import CheckBox
import KDCalendar
import TTGSnackbar
import SwiftyJSON

class Step2ViewController: UIViewController, SSRadioButtonControllerDelegate {
    
    var radioButtonController: SSRadioButtonsController?

    @IBOutlet weak var dateTopConstrainst: NSLayoutConstraint!
    
    var exchag : String = ""
    var discont : String = ""
    var discountNmbr : String = ""
    var maxBudgt : String = ""
    var usingProd : String = ""
    var locatin : String = ""
    var selfe : String = ""
    var shotTop : String = ""
    var numStoris : String = ""
    var numPost : String = ""
    var accptBugt : String = ""
    var startDate : String = "2-03-2019"
    var endDate : String = "7-03-2019"
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var currentYear : Int!
    var age : Int! = 0
    var dat : String!
    
    @IBOutlet weak var shotForTopCheck: CheckBox!
    @IBOutlet weak var selfieCheck: CheckBox!
    @IBOutlet weak var locationCheck: CheckBox!
    @IBOutlet weak var usingProduct: CheckBox!
    @IBOutlet weak var check: CheckBox!
    @IBOutlet weak var acceptView: UIView!
    @IBOutlet weak var budgetSlider: UISlider!
    @IBOutlet weak var currentValLabel: UILabel!
    @IBOutlet weak var totalValLabel: UILabel!
    @IBOutlet weak var bottomContentView: UIView!
    @IBOutlet weak var bottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var numStories: UILabel!
    @IBOutlet weak var numPosts: UILabel!
    @IBOutlet weak var plusOutlet: UIButton!
    @IBOutlet weak var minusOutlet: UIButton!
    @IBOutlet weak var discountField: UITextField!
    @IBOutlet weak var exchangeBtn: UIButton!
    @IBOutlet weak var discountBtn: UIButton!
    @IBOutlet weak var oneday_check: CheckBox!
    @IBOutlet weak var srtDate: UITextField!
    @IBOutlet weak var EndDate: UITextField!
    
    
    
    @IBOutlet weak var optionCView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(rejectList(req_notification:)), name: NSNotification.Name(rawValue: "reqreject"), object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        srtDate.isUserInteractionEnabled = true
        srtDate.addGestureRecognizer(tap)
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapFunction1))
        EndDate.isUserInteractionEnabled = true
        EndDate.addGestureRecognizer(tap1)
        
        maxBudgt = "500"
        
        
        discountField.isHidden = true
       // calenderVie.isHidden = true
        
        optionCView.isHidden = true
       // acceptView.isHidden = true
        
        numPost = "1"
        numStoris = "1"
        
        //MARK - radio button
        radioButtonController = SSRadioButtonsController(buttons: exchangeBtn,discountBtn)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        oneday_check.onClick = { (checked) in
            if checked.isChecked {
                self.EndDate.isEnabled = false
                
            }else {
                self.EndDate.isEnabled = true
            }
        }
        
        usingProduct.onClick = { (checked) in
            if checked.isChecked {
                print(self.usingProduct.title)
                self.usingProd = self.usingProduct.title!
                
            }else {
                self.usingProd = ""
            }
        }
        
        locationCheck.onClick = { (checked) in
            if checked.isChecked {
                print(self.locationCheck.title)
                self.locatin = self.locationCheck.title!
            }else {
                self.locatin = ""
            }
        }
        
        selfieCheck.onClick = { (checked) in
            if checked.isChecked {
                print(self.selfieCheck.title)
                 self.selfe = self.selfieCheck.title!
                
            }else {
                self.selfe = ""
            }
        }
        
        shotForTopCheck.onClick = { (checked) in
            if checked.isChecked {
                print(self.shotForTopCheck.title)
                self.shotTop = self.shotForTopCheck.title!
            }else {
                self.shotTop = ""
            }
        }
        
        check.onClick = { (checkbox) in
            if checkbox.isChecked {
                UIView.animate(withDuration: 0.2) {
                
//                self.acceptView.isHidden = false
//                self.bottomConstraints.constant = 70.0
                self.optionCView.isHidden = false
                    self.accptBugt = checkbox.title!
                    self.dateTopConstrainst.constant = 80.0
                }
            }else {
                UIView.animate(withDuration: 0.2) {
                
//                self.acceptView.isHidden = true
                self.optionCView.isHidden = true
//                self.bottomConstraints.constant = 5.0
                    //self.maxBudgt = ""
                self.numStoris = ""
                    self.numPost = ""
                      self.accptBugt = ""
                    self.dateTopConstrainst.constant = 0.0
                    
                }
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
    }
    @objc func rejectList(req_notification: NSNotification) {
        var req_id : String = ""
        
        if let dict = req_notification.userInfo as NSDictionary? {
            if let id = dict["json"] as? JSON{
                print("id zain :::: \(id[0]["type"])")
                
                if let exchng = id[0]["type"].stringValue as? String {
                    if exchng != ""{
                        if exchng == "Exchange" {
                            exchag = exchng
                            discont = ""
                            radioButtonController?.pressed(exchangeBtn)
                        }else if exchng == "Discount" {
                            discont = exchng
                            exchag = ""
                            radioButtonController?.pressed(discountBtn)
                            if id[0]["discount_field"].stringValue != ""{
                                discountField.text = id[0]["discount_field"].stringValue
                                
                            }
                        }
                    }
                }
                
                if let bgt = id[0]["budget_value"].floatValue as? Float {
                    if bgt != 0.0{
                        budgetSlider.setValue(bgt, animated: true)
                        currentValLabel.text = "\(Int(bgt))"
                        maxBudgt = "\(Int(bgt))"
                    }
                    
                }
                
                if let cntType = id[0]["content_type"].stringValue as? String {
                    print(cntType)
                    let addressStrin = id[0]["content_type"].stringValue.components(separatedBy: ",")
                    for item in 0..<addressStrin.count {
                       print(addressStrin[item])
                        if addressStrin[item] == "Using the product" {
                            usingProduct.isChecked = true
                            usingProd = addressStrin[item]
                        }
                        if addressStrin[item] == "Location" {
                            locationCheck.isChecked = true
                            locatin = addressStrin[item]
                        }
                        if addressStrin[item] == "Selfie" {
                            selfieCheck.isChecked = true
                            selfe = addressStrin[item]
                        }
                        if addressStrin[item] == "Shot from top" {
                            shotForTopCheck.isChecked = true
                            shotTop = addressStrin[item]
                        }
                    }
                    
                    
                }
                
                
                
                if let bgtcheck = id[0]["accep_budget_check"].stringValue as? String {
                    if bgtcheck != ""{
                        check.isChecked = true
                        
                        accptBugt = "Accept Budget"
                        dateTopConstrainst.constant = 80.0
                        self.optionCView.isHidden = false
                        numStories.text = id[0]["number_stories"].stringValue
                        numPosts.text = id[0]["number_post"].stringValue
                        numPost = id[0]["number_post"].stringValue
                        numStoris = id[0]["number_stories"].stringValue
                        
                    }
                    
                }
                
                
            }
        }
    }
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        
        
        doDatePicker(txtField: "start")
       
    }
    @objc func tapFunction1(sender:UITapGestureRecognizer) {
        
        
        doDatePicker(txtField: "end")
        
        
    }
    
    func doDatePicker(txtField : String){
        // DatePicker
        
        //        let inputView = UIView(frame: CGRect(0, 0, self.view.frame.width, 240))
        
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        self.datePicker?.backgroundColor = UIColor.white
        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
        datePicker.center = view.center
        view.addSubview(self.datePicker)
        
        // ToolBar
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.red
        toolBar.backgroundColor=UIColor.white
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        if txtField == "start" {
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
        }else if txtField == "end" {
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick1))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
        }
        
       
        
        //dob.inputAccessoryView=toolBar
        
        //        inputView.addSubview(doneButton)
        
        //        datePicker.addSubview(doneButton)
        self.view.addSubview(toolBar)
        
        
        self.toolBar.isHidden = false
        
        
    }
    
    @objc func cancelClick() {
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        
    }
    
    @objc func doneClick1() {
        
        if srtDate.text == "" {
            let snackbar = TTGSnackbar(message: "Please select starting date first", duration: .middle)
            snackbar.show()
            
        }else if srtDate.text != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.none
            dateFormatter.dateFormat = "YYYY-MM-dd"
            

            let fordate = dateFormatter.date(from: dat)
            if self.datePicker.date > fordate! {
            let dat1 = dateFormatter.string(from: self.datePicker.date)
            EndDate.text = dat1
            }else {
                let snackbar = TTGSnackbar(message: "Ending date must be greater then starting date", duration: .middle)
                snackbar.show()
                EndDate.text = ""
            }
            
        }
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = DateFormatter.Style.none
//        dateFormatter.dateFormat = "YYYY-MM-dd"
//
//        dat = dateFormatter.string(from: self.datePicker.date)
//        print("Did Select: \(dat) ")
//
//
//        let calendar = Calendar.current
//        print("datee ::: \(self.datePicker.date)")
//
//        let components = calendar.dateComponents([.day,.month,.year], from: self.datePicker.date)
//
//
        

        
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        
        
    }
    
    @objc func doneClick() {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
         dat = dateFormatter.string(from: self.datePicker.date)
        print("Did Select: \(dat) ")
        
        
        let calendar = Calendar.current
        print("datee ::: \(self.datePicker.date)")
        
        let components = calendar.dateComponents([.day,.month,.year], from: self.datePicker.date)
        
        
        srtDate.text = dat
        
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        
        
    }
    
    func didSelectButton(selectedButton: UIButton?)
    {
        print(" \(selectedButton?.title(for: .normal))" )
        
        selectedButton?.setTitleColor(UIColor.white, for: .normal)
        
        if selectedButton?.title(for: .normal) == "Exchange" {
            discountField.isHidden = true
            exchag = (selectedButton?.title(for: .normal))!
            discont = ""
            discountNmbr = ""
            print(exchag)
        }else if selectedButton?.title(for: .normal) == "Discount"{
            
//            discountField.isEnabled = true
            discountField.isHidden = false
            
            discont = (selectedButton?.title(for: .normal))!
            exchag = ""
            
        check.isChecked = false
            UIView.animate(withDuration: 0.2) {
                
             //   self.acceptView.isHidden = true
                self.optionCView.isHidden = true
               // self.bottomConstraints.constant = 5.0
            //    self.maxBudgt = ""
                self.numStoris = ""
                self.numPost = ""
                self.accptBugt = ""
                
            }
            
        }
    }
    
    

    @IBAction func disText(_ sender: UITextField) {
        
        discountNmbr = discountField.text!
        print(discountNmbr)
        
    }
    @IBAction func sliderValChange(_ sender: Any) {
        
        currentValLabel.text = "\(Int(budgetSlider.value))"
        
        maxBudgt = "\(Int(budgetSlider.value))"
    }
    
    
    @IBAction func minusAction(_ sender: UIButton) {
        
        if (sender.tag == 0) {
            numStories.text = "1"
            minusOutlet.isEnabled = false
            plusOutlet.isEnabled = true
            numStoris = "1"
        }else if (sender.tag == 1) {
            numPosts.text = "1"
            minusOutlet.isEnabled = false
            plusOutlet.isEnabled = true
            numPost = "1"
        }
        
        
       
    
    }
    @IBAction func plusAction(_ sender: UIButton) {
        if (sender.tag == 0) {
            
            numStories.text = "2"
            plusOutlet.isEnabled = false
            minusOutlet.isEnabled = true
            numStoris = "2"
            
        }else if (sender.tag == 1) {
            
            numPosts.text = "2"
            plusOutlet.isEnabled = false
            minusOutlet.isEnabled = true
            numPost = "2"
        }
        
        
    }
    
    
   
    
}
