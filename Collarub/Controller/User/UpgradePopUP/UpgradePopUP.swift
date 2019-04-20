//
//  UpgradePopUP.swift
//  Collarub
//
//  Created by apple on 20/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class UpgradePopUP: UIViewController {

    var flag = 0
    
    @IBOutlet weak var one_month_btn: UIButton!
    @IBOutlet weak var six_month_btn: UIButton!
    @IBOutlet weak var one_year_btn: UIButton!
    
    
    @IBOutlet weak var one_month_view: UIView!
    @IBOutlet weak var six_month_view: UIView!
    @IBOutlet weak var one_year_view: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0, animations: {
            //self.basic.backgroundColor = .brown
            self.six_month_view.frame.origin.y -= 10
            self.six_month_btn.frame.origin.y += 10
            self.six_month_view.layer.borderWidth = 3
            self.six_month_view.layer.borderColor = #colorLiteral(red: 0.2156862745, green: 0.6784313725, blue: 0.5882352941, alpha: 1)
            self.six_month_view.frame.size.height += 20
        })
        
        one_month_btn.isEnabled = true
        six_month_btn.isEnabled = false
        one_year_btn.isEnabled = true
        flag=2
    }
    
    @IBAction func month_btn(_ sender: UIButton) {
        print("one_month btn")
        
        
        if(flag==2){
            UIView.animate(withDuration: 0, animations: {
                //self.basic.backgroundColor = .brown
                self.six_month_view.frame.origin.y += 10
                self.six_month_btn.frame.origin.y -= 10
                self.six_month_view.layer.borderWidth = 3
                self.six_month_view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.six_month_view.frame.size.height -= 20
            })
        }
        else if(flag==3){
            UIView.animate(withDuration: 0, animations: {
                //self.basic.backgroundColor = .brown
                self.one_year_view.frame.origin.y += 10
                self.one_year_btn.frame.origin.y -= 10
                self.one_year_view.layer.borderWidth = 3
                self.one_year_view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.one_year_view.frame.size.height -= 20
            })

        }
        UIView.animate(withDuration: 0, animations: {
            //self.basic.backgroundColor = .brown
            self.one_month_view.frame.origin.y -= 10
            self.one_month_btn.frame.origin.y += 10
            self.one_month_view.layer.borderWidth = 3
            self.one_month_view.layer.borderColor = #colorLiteral(red: 0.2156862745, green: 0.6784313725, blue: 0.5882352941, alpha: 1)
            self.one_month_view.frame.size.height += 20
        })
    
        one_month_btn.isEnabled = false
        six_month_btn.isEnabled = true
        one_year_btn.isEnabled = true
        flag=1
        
    }
    
    @IBAction func six_month_btn(_ sender: UIButton) {
//        print("one_month btn")
        
        
        if(flag==1){
            UIView.animate(withDuration: 0, animations: {
                //self.basic.backgroundColor = .brown
                self.one_month_view.frame.origin.y += 10
                self.one_month_btn.frame.origin.y -= 10
                self.one_month_view.layer.borderWidth = 3
                self.one_month_view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.one_month_view.frame.size.height -= 20
            })
        }
        else if(flag==3){
            UIView.animate(withDuration: 0, animations: {
                //self.basic.backgroundColor = .brown
                self.one_year_view.frame.origin.y += 10
                self.one_year_btn.frame.origin.y -= 10
                self.one_year_view.layer.borderWidth = 3
                self.one_year_view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.one_year_view.frame.size.height -= 20
            })
            
        }
        UIView.animate(withDuration: 0, animations: {
            //self.basic.backgroundColor = .brown
            self.six_month_view.frame.origin.y -= 10
            self.six_month_btn.frame.origin.y += 10
            self.six_month_view.layer.borderWidth = 3
            self.six_month_view.layer.borderColor = #colorLiteral(red: 0.2156862745, green: 0.6784313725, blue: 0.5882352941, alpha: 1)
            self.six_month_view.frame.size.height += 20
        })
        
        one_month_btn.isEnabled = true
        six_month_btn.isEnabled = false
        one_year_btn.isEnabled = true
        flag=2
    }
    
    @IBAction func one_year_btn(_ sender: UIButton) {
        print("one_YEAR btn")
        
        
        
        if(flag==1){
            UIView.animate(withDuration: 0, animations: {
                //self.basic.backgroundColor = .brown
                self.one_month_view.frame.origin.y += 10
                self.one_month_btn.frame.origin.y -= 10
                self.one_month_view.layer.borderWidth = 3
                self.one_month_view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.one_month_view.frame.size.height -= 20
            })
        }
        else  if(flag==2){
            UIView.animate(withDuration: 0, animations: {
                //self.basic.backgroundColor = .brown
                self.six_month_view.frame.origin.y += 10
                self.six_month_btn.frame.origin.y -= 10
                self.six_month_view.layer.borderWidth = 3
                self.six_month_view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.six_month_view.frame.size.height -= 20
            })
        }
        UIView.animate(withDuration: 0, animations: {
            //self.basic.backgroundColor = .brown
            self.one_year_view.frame.origin.y -= 10
            self.one_year_btn.frame.origin.y += 10
            self.one_year_view.layer.borderWidth = 3
            self.one_year_view.layer.borderColor = #colorLiteral(red: 0.2156862745, green: 0.6784313725, blue: 0.5882352941, alpha: 1)
            self.one_year_view.frame.size.height += 20
        })
        
        one_month_btn.isEnabled = true
        six_month_btn.isEnabled = true
        one_year_btn.isEnabled = false
        flag=3
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
