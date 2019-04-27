//
//  CampaignManagementViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 11/03/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class CampaignManagementViewController: UIViewController, PageViewControllerDelegate {

    @IBOutlet weak var currentBtn: UIButton!
    @IBOutlet weak var endedBtn: UIButton!
    @IBOutlet weak var draftBtn: UIButton!
    @IBOutlet weak var pageView: UIView!
    
    var pageViewController:PageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callingInViewDidLoad()

        uiNavegationImage()
        
    }
    
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let _pageViewController = segue.destination as? PageViewController {
            _pageViewController.viewControllerIdentifiers = ["current","ended","draft"]
            
            _pageViewController.pageDelegate = nil
            
            self.pageViewController = _pageViewController
            
            
        }
    }
    
    
    func callingInViewDidLoad(){
        
        currentBtn.titleLabel?.textAlignment = .center
        currentBtn.titleLabel?.numberOfLines = 0
        endedBtn.titleLabel?.textAlignment = .center
        endedBtn.titleLabel?.numberOfLines = 0
        draftBtn.titleLabel?.textAlignment = .center
        draftBtn.titleLabel?.numberOfLines = 0
        
        borderBtn(btn: currentBtn)
        borderBtn(btn: endedBtn)
        borderBtn(btn: draftBtn)
    }
    
    func borderBtn(btn : UIButton){
        
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor(named: "ThemeColor1")?.cgColor
    }

    
    func changeTab(btn1 : UIButton, btn2 : UIButton, btn3 : UIButton){
        
        
        btn1.setTitleColor(UIColor.white, for: .normal)
        btn1.backgroundColor = UIColor(named: "themecolor4")
        
        btn2.setTitleColor(UIColor(named: "themecolor4"), for: .normal)
        btn2.backgroundColor = UIColor.white
        btn2.layer.borderWidth = 0.5
        btn2.layer.borderColor = UIColor(named: "ThemeColor1")?.cgColor
        
        btn3.setTitleColor(UIColor(named: "themecolor4"), for: .normal)
        btn3.backgroundColor = UIColor.white
        btn3.layer.borderWidth = 0.5
        btn3.layer.borderColor = UIColor(named: "ThemeColor1")?.cgColor
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, didUpdatePageIndex index: Int) {
        //self.animateBottomBar(index: index)
        print("hello")
        UIView.animate(withDuration: 0.2) {
        }
        
        if index == 0 {
            // changeTab(btn1: localAnnouncement, btn2: onlineAnnouncement)
            
        }else {
            // changeTab(btn1: onlineAnnouncement, btn2: localAnnouncement)
        }
        
    }
    
    
    @IBAction func currentClick(_ sender: UIButton) {
        
        pageViewController?.moveToPage(index: 0)
        
        changeTab(btn1: sender, btn2: endedBtn, btn3: draftBtn)
        
        
    }
    
    
    @IBAction func endedClick(_ sender: UIButton) {
        pageViewController?.moveToPage(index: 1)
        
        changeTab(btn1: sender, btn2: currentBtn, btn3: draftBtn)
        
        
    }
    
    @IBAction func draftClick(_ sender: UIButton) {
        
        pageViewController?.moveToPage(index: 2)
        
        changeTab(btn1: sender, btn2: currentBtn, btn3: endedBtn)
        
        
    }
    
    @IBAction func addCampaign(_ sender: UIBarButtonItem) {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "stepController") as! StepViewController
        vc.backCheck = true
        present(vc, animated: true, completion: nil)
        
    }
    
}
