//
//  Extension+Keyboard.swift
//  Land
//
//  Created by Invision on 08/11/2017.
//  Copyright © 2017 Invision. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardHandler : class{
    var containerScrollView:UIScrollView { get }
    func keyboardWillShow(notification:Notification)
    func keyboardWillHide(notification:Notification)
}

extension KeyboardHandler where Self: UIViewController{

    func registerKeyboardNotifications()->(willShowObserver:NSObjectProtocol, willHideObserver:NSObjectProtocol){
        
        let willShowObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (notification) in
            self.keyboardWillShow(notification: notification)
        }
        
        let willHideObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { (notification) in
            self.keyboardWillHide(notification: notification)
        }
        
        return (willShowObserver,willHideObserver)
        
    }
    
    func deregisterKeyboardNotification(observers:(NSObjectProtocol,NSObjectProtocol)){
        NotificationCenter.default.removeObserver(observers.0)
        NotificationCenter.default.removeObserver(observers.1)

    }
    
    func keyboardWillShow(notification:Notification){
        print(#function)
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        containerScrollView.contentInset = contentInsets
        containerScrollView.scrollIndicatorInsets = contentInsets
    }
    
    func keyboardWillHide(notification:Notification){
        print(#function)
        containerScrollView.contentInset = .zero
        containerScrollView.scrollIndicatorInsets = .zero
    }
}
