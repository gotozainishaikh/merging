//
//  MyCollaborationViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 16/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import KDCalendar

class MyCollaborationViewController: UIViewController, PageViewControllerDelegate{
   
    
  

    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var localBtn: UIButton!
    @IBOutlet weak var pagingView: UIView!
    
    var pageViewController:PageViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let _pageViewController = segue.destination as? PageViewController {
            _pageViewController.viewControllerIdentifiers = ["collaborationStatus","completeCollaboration"]
            _pageViewController.pageDelegate = self
            
            self.pageViewController = _pageViewController
            
            
        }
    }
    
    func changeTab(btn1 : UIButton, btn2 : UIButton){
        btn1.backgroundColor = UIColor(named: "themeColor2")
        btn1.setTitleColor(UIColor.white, for: .normal)
        btn2.backgroundColor = UIColor.white
        btn2.setTitleColor(UIColor.black, for: .normal)
    }
    
    func pageViewController(pageViewController: UIPageViewController, didUpdatePageIndex index: Int) {
        print("Hello")
        UIView.animate(withDuration: 0.2) {
        }
        
        if index == 0 {
            changeTab(btn1: localBtn, btn2: onlineBtn)
            
        }else {
            changeTab(btn1: onlineBtn, btn2: localBtn)
        }
    }
    

    

}
