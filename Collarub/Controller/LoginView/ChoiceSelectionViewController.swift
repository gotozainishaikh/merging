//
//  ChoiceSelectionViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 12/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import CheckBox
import iOSDropDown

class ChoiceSelectionViewController: UIViewController {

    @IBOutlet weak var foodCheck: CheckBox!
    @IBOutlet weak var sportsCheck: CheckBox!
    @IBOutlet weak var fashionCheck: CheckBox!
    @IBOutlet weak var beautyCheck: CheckBox!
    @IBOutlet weak var eventsCheck: CheckBox!
    @IBOutlet weak var travelCheck: CheckBox!
    @IBOutlet weak var digitalCheck: CheckBox!
    @IBOutlet weak var parentingCheck: CheckBox!
    @IBOutlet weak var homeCheck: CheckBox!
    @IBOutlet weak var automatCheck: CheckBox!
    @IBOutlet weak var petCheck: CheckBox!
    @IBOutlet weak var categoryDrop: DropDown!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var mailText: UITextField!
    
    var count = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryDrop.layer.borderWidth = 1
        categoryDrop.layer.borderColor = UIColor.white.cgColor
        
        mailText.layer.borderWidth = 1
        mailText.layer.borderColor = UIColor.white.cgColor
        
        
        locationText.layer.borderWidth = 1
        locationText.layer.borderColor = UIColor.white.cgColor
        
        categoryDrop.optionArray = ["Influencer/Blogger", "Singer", "Dancer","Model","Athlete","Actor","Youtuber","Photographer","Filmaker","Write/Author","Stylist","Public Personality"]
        
        // MARK - Drop Down selecting
        categoryDrop.arrowSize = 10
        categoryDrop.didSelect{(selectedText , index , id) in
            print("Selected String: \(selectedText) \n index: \(index) \n Id: \(id)")
          //  self.categoryDrop = selectedText
            // self.selectedtex = selectedText
        }
        
        foodCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.foodCheck.title)
                    
                    self.count += 1
                    print(self.count)
                }else {
                    checked.isChecked = false
                }
              
                
            }else {
                self.count -= 1
                print(self.count)
            }
        }
        
        sportsCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.sportsCheck.title)
                    
                    self.count += 1
                    print(self.count)
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
            }
        }
        
        fashionCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.fashionCheck.title)
                    
                    self.count += 1
                    print(self.count)
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
            }
        }
        
        
        beautyCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.fashionCheck.title)
                    
                    self.count += 1
                    print(self.count)
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
            }
        }
        
        
        eventsCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.eventsCheck.title)
                    
                    self.count += 1
                    print(self.count)
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
            }
        }
        
        
        travelCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.travelCheck.title)
                    
                    self.count += 1
                    print(self.count)
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
            }
        }
        
        
        digitalCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.digitalCheck.title)
                    
                    self.count += 1
                    print(self.count)
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
            }
        }
        
        
        
        parentingCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.parentingCheck.title)
                    
                    self.count += 1
                    print(self.count)
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
            }
        }
        
        
        
        homeCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.homeCheck.title)
                    
                    self.count += 1
                    print(self.count)
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
            }
        }
        
        
        
        automatCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.automatCheck.title)
                    
                    self.count += 1
                    print(self.count)
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
            }
        }
        
        
        
        petCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.petCheck.title)
                    
                    self.count += 1
                    print(self.count)
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
            }
        }
        
        
        
    }
    

}
