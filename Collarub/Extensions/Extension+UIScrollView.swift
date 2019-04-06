//
//  Extension+UIScrollView.swift
//  Land
//
//  Created by Invision on 07/11/2017.
//  Copyright © 2017 Invision. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
    
}
