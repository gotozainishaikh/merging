//
//  Extension+String.swift
//  Land
//
//  Created by Invision on 04/12/2017.
//  Copyright © 2017 Invision. All rights reserved.
//

import Foundation

extension String{
    func splitInNames()->(String,String)?{
        var components = self.components(separatedBy: " ").filter({!$0.isEmpty})
        if(components.count > 0)
        {
            let firstName = components.removeFirst()
            let lastName = components.joined(separator: " ")
            return (firstName, lastName)
        }
        return nil
    }
}

extension String{
    var formattedDateString:String?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: self)
        formatter.dateFormat = "dd MMMM yyyy"
        if date == nil{
            return nil
        }
        return formatter.string(from: date!)
    }
    var converToInt : Int{
        get{
            return Int(self) ?? 0
        }
    }
    var converToDouble : Double?{
        
        get{
            
            return Double(self)
        }
    }
}

extension String{
    func isVideoURL() -> Bool{
        let allowedExtensions = ["mp4", "m4a", "m4v", "f4v", "f4a", "m4b", "m4r", "f4b", "mov"]
        if let pathExtension = URL(string: self)?.pathExtension, allowedExtensions.contains(pathExtension){
            return true
        }
        return false
    }
}
