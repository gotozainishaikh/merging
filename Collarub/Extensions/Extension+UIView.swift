//
//  Extension+UIView.swift
//  Land
//
//  Created by Invision on 25/10/2017.
//  Copyright © 2017 Invision. All rights reserved.
//

import Foundation
import UIKit
//import NVActivityIndicatorView

extension UIView{
    
    func applyShadow(shadowColor:UIColor){
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
    }
    
    func applyShadow(shadowColor:UIColor, cornerRadius: CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
    }
    
    func drawUnderline(lineColor:UIColor,lineWidth:CGFloat)->CALayer{
        
        let underline = CALayer()
        underline.borderColor = lineColor.cgColor
        underline.frame = CGRect(x: 0, y: self.frame.size.height - lineWidth, width:  self.frame.size.width, height: lineWidth)
        underline.borderWidth = lineWidth
        self.layer.addSublayer(underline)
        self.layer.masksToBounds = true
        return underline
        
    }
    func fadeIn(withDuration duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    func fadeOut(withDuration duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}



//extension UIView {
//    var activityIndicatorTag: Int { return 999999 }
//    
//    
//    func startActivityIndicator(
//        style: UIActivityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge,
//        location: CGPoint? = nil) {
//        
//        
//        if let _ = self.viewWithTag(self.activityIndicatorTag) as? NVActivityIndicatorView {
//            return
//        }
//        
//        
//        //Set the position - defaults to `center` if no`location`
//        
//        //argument is provided
//        
//        let loc = location ?? self.center
//        
//        //Ensure the UI is updated from the main thread
//        
//        //in case this method is called from a closure
//        //
//        //        DispatchQueue.main.async {
//        //
//        //Create the activity indicator
//        
//        let frame = CGRect(origin: loc, size: CGSize(width: 20, height: 20))
//        let activityIndicator = NVActivityIndicatorView(frame: frame, color: UIColor.primaryYellow)
//        //Add the tag so we can find the view in order to remove it later
//        
//        activityIndicator.tag = self.activityIndicatorTag
//        //Set the location
//        
//        activityIndicator.center = loc
//        //activityIndicator.hidesWhenStopped = true
//        //activityIndicator.color = UIColor.primaryYellow
//        //Start animating and add the view
//        
//        activityIndicator.startAnimating()
//        self.addSubview(activityIndicator)
//        // }
//        
//    }
//    
//    
//    func stopActivityIndicator() {
//        
//        //Again, we need to ensure the UI is updated from the main thread!
//        
//        
//        DispatchQueue.main.async {
//            if let activityIndicator = self.viewWithTag(self.activityIndicatorTag) as? NVActivityIndicatorView {
//                activityIndicator.stopAnimating()
//                activityIndicator.removeFromSuperview()
//            }
//        }
//        
//    }
//    
//    func adjustActivityIndicatorPosition(){
//        if let activityIndicator = self.viewWithTag(self.activityIndicatorTag) as? NVActivityIndicatorView {
//            activityIndicator.center = self.center
//        }
//    }
//}


