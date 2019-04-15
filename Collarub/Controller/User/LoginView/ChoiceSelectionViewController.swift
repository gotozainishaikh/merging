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
import GooglePlacesSearchController

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
    var choice1:String = ""
    var choice2:String = ""
    
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
                    
                    if(self.choice1==""){
                        self.choice1 = self.foodCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.foodCheck.title!
                    }
                    
                }else {
                    checked.isChecked = false
                   
                }
              
                
            }else {
                self.count -= 1
                print(self.count)
                
                if(self.choice2 == self.foodCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.foodCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        sportsCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.sportsCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.sportsCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.sportsCheck.title!
                    }
                    
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.sportsCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.sportsCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        fashionCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.fashionCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.fashionCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.fashionCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.fashionCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.fashionCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        beautyCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.fashionCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.fashionCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.fashionCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.fashionCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.fashionCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        eventsCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.eventsCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.eventsCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.eventsCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.eventsCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.eventsCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        travelCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.travelCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.travelCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.travelCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.travelCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.travelCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        digitalCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.digitalCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.digitalCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.digitalCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.digitalCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.digitalCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        
        parentingCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.parentingCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.parentingCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.parentingCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.parentingCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.parentingCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        
        homeCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.homeCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.homeCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.homeCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.homeCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.homeCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        
        automatCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.automatCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.automatCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.automatCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.automatCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.automatCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        
        petCheck.onClick = { (checked) in
            if checked.isChecked {
                
                if self.count < 3{
                    print(self.petCheck.title)
                    
                    self.count += 1
                    print(self.count)
                    if(self.choice1==""){
                        self.choice1 = self.petCheck.title!
                    }
                    else if(self.choice2==""){
                        self.choice2 = self.petCheck.title!
                    }
                }else {
                    checked.isChecked = false
                }
                
                
            }else {
                self.count -= 1
                print(self.count)
                if(self.choice2 == self.petCheck.title!){
                    self.choice2 = ""
                }
                else if(self.choice1 == self.petCheck.title!){
                    self.choice1 = ""
                }
            }
        }
        
        
        
        
        
    }
    
    
    @IBAction func location_edit(_ sender: UITextField) {
        
        present(placesSearchController, animated: true, completion: nil)
        
    }
    
    @IBAction func cont_btn(_ sender: UIButton) {
        
        print("choice1=\(choice1)")
        print("choice2=\(choice2)")
        
        let choiceSelectionViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainTabController") as! mainTabController
        
        
        self.present(choiceSelectionViewController, animated: true, completion: nil)
    }
    
    let GoogleMapsAPIServerKey = "AIzaSyCp93QINHvSoa0pdd1jK-oOsCZsZjAeQVI"
    
    lazy var placesSearchController: GooglePlacesSearchController = {
        let controller = GooglePlacesSearchController(delegate: self,
                                                      apiKey: GoogleMapsAPIServerKey,
                                                      placeType: .address
            
        )
        
        return controller
    }()

}

extension ChoiceSelectionViewController: GooglePlacesAutocompleteViewControllerDelegate {
    func viewController(didAutocompleteWith place: PlaceDetails) {
        print(place.description)
        var lat:String = "\((place.coordinate?.latitude)!)"
        var long:String = "\((place.coordinate?.longitude)!)"
        print("lat=\(lat), long=\(long)")
        locationText.text = place.name
        //addrss = place.name!
        
        placesSearchController.isActive = false
    }
}
