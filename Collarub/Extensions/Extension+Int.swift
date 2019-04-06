//
//  Extension+Int.swift
//  Land
//
//  Created by Invision on 30/01/2018.
//  Copyright © 2018 Invision. All rights reserved.
//

import Foundation

extension Int{
    
    func toRoman() -> String {
        
        let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        
        var romanValue = ""
        var startingValue = self
        
        for (index, romanChar) in romanValues.enumerated() {
            var arabicValue = arabicValues[index]
            
            var div = startingValue / arabicValue
            
            if (div > 0)
            {
                for j in 0..<div
                {
                    //println("Should add \(romanChar) to string")
                    romanValue += romanChar
                }
                
                startingValue -= arabicValue * div
            }
        }
        
        return romanValue
    }
    
}
extension Int{
    
    var converToString : String{
        get{
             return String(self)
         }
     }
    var converToDouble : Double?{
        get{
            return self == nil ? nil: Double(self)
        }
    }
}
