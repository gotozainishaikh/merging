//
//  UserCoreData.swift
//  Collarub
//
//  Created by apple on 23/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//


import Foundation
import UIKit
import CoreData

final class UserCoreData{
    
    
    static var user_id : String = ""
    static var username : String = ""
    //static var email : String = ""
    static var profile_picture : String = ""
    static var full_name : String = ""
    static var followers : String = ""
    static var follows : String = ""
    
    
    static func fetchCoreData(){
        
 
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
        
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        self.user_id = res.value(forKey: "user_id") as! String
        self.username = res.value(forKey: "username") as! String
        //self.email = res.value(forKey: "email") as! String
        self.profile_picture = res.value(forKey: "profile_picture") as! String
        self.full_name = res.value(forKey: "full_name") as! String
       // self.followers = res.value(forKey: "followers") as! String
       
        
    }
}
