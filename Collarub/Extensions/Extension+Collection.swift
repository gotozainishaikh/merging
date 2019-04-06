//
//  Extension+Collection.swift
//  Land
//
//  Created by Invision on 15/11/2017.
//  Copyright © 2017 Invision. All rights reserved.
//

import Foundation

extension Collection {
    
    /**
     Return index if is safe, if not return nil
     http://stackoverflow.com/a/30593673/517707
     */
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
