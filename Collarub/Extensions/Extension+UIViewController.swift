//
//  Extension+UIViewController.swift
//  Land
//
//  Created by Invision on 26/10/2017.
//  Copyright © 2017 Invision. All rights reserved.
//

import Foundation
import UIKit
//import NVActivityIndicatorView

extension UIViewController{
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showAlert(title:String? = "Error",message:String,completion:(()->Void)? = nil){
        let alertController=UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            completion?()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

//extension UIViewController{
//    func showActivityIndicator(){
//        let indicator = NVActivityIndicatorView(frame: CGRect(origin: self.view.center, size: CGSize(width: 50, height: 50)))
//        indicator.center = self.view.center
//        indicator.color = UIColor.blue
//        self.view.addSubview(indicator)
//        indicator.startAnimating()
//    }
//    
//    func removeActivityIndicator(){
//        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//    }
//}


//extension UIViewController {
//    var activityIndicatorTag: Int { return 999999 }
//
//
//    func startActivityIndicator(
//        style: UIActivityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge,
//        location: CGPoint? = nil) {
//
//
//        if let _ = self.view.viewWithTag(self.activityIndicatorTag) as? NVActivityIndicatorView {
//            return
//        }
//
//
//        //Set the position - defaults to `center` if no`location`
//
//        //argument is provided
//
//        let loc = location ?? self.view.center
//
//        //Ensure the UI is updated from the main thread
//
//        //in case this method is called from a closure
////
////        DispatchQueue.main.async {
////
//            //Create the activity indicator
//
//            let frame = CGRect(origin: loc, size: CGSize(width: 50, height: 50))
//            let activityIndicator = NVActivityIndicatorView(frame: frame, color: UIColor.primaryYellow)
//            //Add the tag so we can find the view in order to remove it later
//
//            activityIndicator.tag = self.activityIndicatorTag
//            //Set the location
//
//            activityIndicator.center = loc
//            //activityIndicator.hidesWhenStopped = true
//            //activityIndicator.color = UIColor.primaryYellow
//            //Start animating and add the view
//
//            activityIndicator.startAnimating()
//            self.view.addSubview(activityIndicator)
//       // }
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
//            if let activityIndicator = self.view.viewWithTag(self.activityIndicatorTag) as? NVActivityIndicatorView {
//                activityIndicator.stopAnimating()
//                activityIndicator.removeFromSuperview()
//            }
//        }
//
//    }
//
//    func adjustActivityIndicatorPosition(){
//        if let activityIndicator = self.view.viewWithTag(self.activityIndicatorTag) as? NVActivityIndicatorView {
//            activityIndicator.center = self.view.center
//        }
//    }
//
//    func startNVIndicator(){
//        let activityData = ActivityData(color: UIColor.primaryYellow)
//        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
//    }
//
//    func stopNVIndicator(){
//        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//    }
//
//
//}


