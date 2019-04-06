//
//  Extension+Date.swift
//  Land
//
//  Created by Invision on 20/12/2017.
//  Copyright © 2017 Invision. All rights reserved.
//

import Foundation

extension Date{
    var toString:String{
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: self)
    }
}
extension String{
    func convertToAppDateFormat()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let dated = dateFormatter.date(from:self ) else {return ""}
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: dated)
    }
}
