//
//  Step1ViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 14/02/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import iOSDropDown

class Step1ViewController: UIViewController, SSRadioButtonControllerDelegate {

    var radioButtonController: SSRadioButtonsController?
    var api = AlamofireApi()
    var local : String = ""
    var online : String = ""
    var category : String = ""
    var getCategory : [String] = [String]()
    var url = FixVariable()
    
    @IBOutlet weak var localBtn: UIButton!
    @IBOutlet weak var freeBtn: UIButton!
    @IBOutlet weak var categoryDropDown: DropDown!
    var selectedtex : String!
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(rejectList(req_notification:)), name: NSNotification.Name(rawValue: "reqreject"), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let reqDataDict1 = ["cat_name": "ssad","type":"ssaffd"]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "list"), object: nil, userInfo: reqDataDict1)
        
    }
    
    func allCategory(){
    
        api.alamofireApi(url: "\(self.url.weburl)/get_collab_categories.php") { (json) in
            
            
            for item in 0..<json.count {
                
                print("yes :: \(json[item]["category_name"].stringValue)")
                
                self.categoryDropDown.optionArray.append(json[item]["category_name"].stringValue)
                
            }
        }
    }
    
    @objc func rejectList(req_notification: NSNotification) {
        
        var req_id : String = ""
        
        if let dict = req_notification.userInfo as NSDictionary? {
            if let id = dict["cat_name"] as? String{
                print("id :::: "+id)
                // print("hosp_id="+hosp_id!)
                
                if id != ""{
                    self.category = id
                    categoryDropDown.text = id
                    
                }
            }
            if let coltype = dict["type"] as? String{
               // print("id :::: "+id)
                // print("hosp_id="+hosp_id!)
                
                if coltype != ""{
//                    self.category = id
//                    categoryDropDown.text = id
//
                    if coltype == "Local"{
                        local = coltype
                        online = ""
                        radioButtonController?.pressed(localBtn)
                    }else if coltype == "Online"{
                        online = coltype
                        local = ""
                        radioButtonController?.pressed(freeBtn)
                    }
                }
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryDropDown.layer.borderColor = UIColor.white.cgColor
        categoryDropDown.layer.borderWidth = 1
        
        categoryDropDown.selectedRowColor = UIColor.lightGray
        
//        categoryDropDown.optionArray = ["Food", "Sport", "Fashion","Beauty & Healtcare","Events","Travel","Digital & Devices","Parenting","Home & Decors","Automotive","Pets"]
//

        allCategory()
        // print("valllll :: "+category)
        //Sub Category subCategoryDropDown
       
        
        categoryDropDown.didSelect{(selectedText , index , id) in
//            print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
            self.category = selectedText
        }
        
        
        //MARK - radio button
        radioButtonController = SSRadioButtonsController(buttons: localBtn,freeBtn)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
        categoryDropDown.arrowSize = 10
        
        
    }
    
    func didSelectButton(selectedButton: UIButton?)
    {
        print(" \(selectedButton?.title(for: .normal))" )
        selectedButton?.setTitleColor(UIColor.white, for: .normal)
        if selectedButton?.title(for: .normal) == "Local" {
            local = (selectedButton?.title(for: .normal))!
            online = ""
        }else if selectedButton?.title(for: .normal) == "Online"{
            online = (selectedButton?.title(for: .normal))!
            local = ""
        }else {
            local = ""
            online = ""
        }
    }
    

    
    @IBAction func done(_ sender: Any) {
        
        categoryDropDown.touchAction()
        print(selectedtex)
    }
    
}
