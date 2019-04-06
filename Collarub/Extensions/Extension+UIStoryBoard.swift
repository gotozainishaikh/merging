//
//  UIS/Users/invision/Land iOS App/Land/Land/Extensions/Extension+UIStoryBoard.swifttoryBoard+Extension.swift
//  Land
//
//  Created by Invision on 23/10/2017.
//  Copyright © 2017 Invision. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard{
    func instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T? {
        return instantiateViewController(withIdentifier: String(describing: name)) as? T
    }
    
//    func instantiateViewController(storyBoardID: String) -> UIViewController {
//        return self.storyboard!.instantiateViewController(withIdentifier: storyBoardID)
//    }
}
