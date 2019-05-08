//
//  UpgradePopUP.swift
//  Collarub
//
//  Created by apple on 20/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class UpgradePopUP: UIViewController {

    
    let story = UIStoryboard(name: "User", bundle: nil)

    var flag = 0
    
    //Package price
    var plan:Double = 0
    
    @IBOutlet weak var one_month_btn: UIButton!
    @IBOutlet weak var six_month_btn: UIButton!
    @IBOutlet weak var one_year_btn: UIButton!
    
    
    @IBOutlet weak var one_month_view: UIView!
    @IBOutlet weak var six_month_view: UIView!
    @IBOutlet weak var one_year_view: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap1(_:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap2(_:)))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap3(_:)))
        
        one_month_view.addGestureRecognizer(tap1)
        six_month_view.addGestureRecognizer(tap2)
        one_year_view.addGestureRecognizer(tap3)
        
        view.isUserInteractionEnabled = true
        showAnimate()
        
    }
    
    @objc func handleTap1(_ sender: UITapGestureRecognizer) {
        
        print("one_month btn")
        
        plan = 499
        
        if(flag==2){
            UIView.animate(withDuration: 0, animations: {
                //self.basic.backgroundColor = .brown
                self.six_month_view.frame.origin.y += 10
                self.six_month_btn.frame.origin.y -= 10
                self.six_month_view.layer.borderWidth = 3
                self.six_month_view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.six_month_view.frame.size.height -= 20
                self.six_month_view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
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
                self.one_year_view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
            })
            
        }
        UIView.animate(withDuration: 0, animations: {
            //self.basic.backgroundColor = .brown
            self.one_month_view.frame.origin.y -= 10
            self.one_month_btn.frame.origin.y += 10
            self.one_month_view.layer.borderWidth = 3
            self.one_month_view.layer.borderColor = #colorLiteral(red: 0.2666666667, green: 0.462745098, blue: 0.4196078431, alpha: 1)
            self.one_month_view.frame.size.height += 20
            self.one_month_view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        })
        
        one_month_btn.isEnabled = false
        six_month_btn.isEnabled = true
        one_year_btn.isEnabled = true
        
        one_month_view.isUserInteractionEnabled = false
        six_month_view.isUserInteractionEnabled = true
        one_year_view.isUserInteractionEnabled = true
        
        
        flag=1
        
    }
    
    @objc func handleTap2(_ sender: UITapGestureRecognizer) {
        //        print("one_month btn")
        
        
        plan = 2245
        if(flag==1){
            UIView.animate(withDuration: 0, animations: {
                //self.basic.backgroundColor = .brown
                self.one_month_view.frame.origin.y += 10
                self.one_month_btn.frame.origin.y -= 10
                self.one_month_view.layer.borderWidth = 3
                self.one_month_view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.one_month_view.frame.size.height -= 20
                self.one_month_view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
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
                self.one_year_view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
            })
            
        }
        UIView.animate(withDuration: 0, animations: {
            //self.basic.backgroundColor = .brown
            self.six_month_view.frame.origin.y -= 10
            self.six_month_btn.frame.origin.y += 10
            self.six_month_view.layer.borderWidth = 3
            self.six_month_view.layer.borderColor = #colorLiteral(red: 0.2666666667, green: 0.462745098, blue: 0.4196078431, alpha: 1)
            self.six_month_view.frame.size.height += 20
            self.six_month_view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        })
        
        one_month_btn.isEnabled = true
        six_month_btn.isEnabled = false
        one_year_btn.isEnabled = true
        
        one_month_view.isUserInteractionEnabled = true
        six_month_view.isUserInteractionEnabled =  false
        one_year_view.isUserInteractionEnabled = true
        flag=2
    }
    
    @objc func handleTap3(_ sender: UITapGestureRecognizer) {
        
        print("one_YEAR btn")
        
        plan = 3592
        
        if(flag==1){
            UIView.animate(withDuration: 0, animations: {
                //self.basic.backgroundColor = .brown
                self.one_month_view.frame.origin.y += 10
                self.one_month_btn.frame.origin.y -= 10
                self.one_month_view.layer.borderWidth = 3
                self.one_month_view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.one_month_view.frame.size.height -= 20
                self.one_month_view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
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
                self.six_month_view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
            })
        }
        UIView.animate(withDuration: 0, animations: {
            //self.basic.backgroundColor = .brown
            self.one_year_view.frame.origin.y -= 10
            self.one_year_btn.frame.origin.y += 10
            self.one_year_view.layer.borderWidth = 3
            self.one_year_view.layer.borderColor = #colorLiteral(red: 0.2666666667, green: 0.462745098, blue: 0.4196078431, alpha: 1)
            self.one_year_view.frame.size.height += 20
            self.one_year_view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
        })
        
        one_month_btn.isEnabled = true
        six_month_btn.isEnabled = true
        one_year_btn.isEnabled = false
        
        one_month_view.isUserInteractionEnabled = true
        six_month_view.isUserInteractionEnabled = true
        one_year_view.isUserInteractionEnabled =  false
        flag=3
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
//        self.view.addGestureRecognizer(tap)
//        
//        self.view.isUserInteractionEnabled = true
        plan = 2245
        
        UIView.animate(withDuration: 0, animations: {
            //self.basic.backgroundColor = .brown
            self.six_month_view.frame.origin.y -= 10
            self.six_month_btn.frame.origin.y += 10
            self.six_month_view.layer.borderWidth = 3
            self.six_month_view.layer.borderColor = #colorLiteral(red: 0.2666666667, green: 0.462745098, blue: 0.4196078431, alpha: 1)
            self.six_month_view.frame.size.height += 20
            self.six_month_view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        })
        
        one_month_btn.isEnabled = true
        six_month_btn.isEnabled = false
        one_year_btn.isEnabled = true
        flag=2
    }
    
    @IBAction func month_btn(_ sender: UIButton) {
        print("one_month btn")
        
        plan = 499
        
        if(flag==2){
            UIView.animate(withDuration: 0, animations: {
                //self.basic.backgroundColor = .brown
                self.six_month_view.frame.origin.y += 10
                self.six_month_btn.frame.origin.y -= 10
                self.six_month_view.layer.borderWidth = 3
                self.six_month_view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.six_month_view.frame.size.height -= 20
                self.six_month_view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
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
                 self.one_year_view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
            })

        }
        UIView.animate(withDuration: 0, animations: {
            //self.basic.backgroundColor = .brown
            self.one_month_view.frame.origin.y -= 10
            self.one_month_btn.frame.origin.y += 10
            self.one_month_view.layer.borderWidth = 3
            self.one_month_view.layer.borderColor = #colorLiteral(red: 0.2666666667, green: 0.462745098, blue: 0.4196078431, alpha: 1)
            self.one_month_view.frame.size.height += 20
            self.one_month_view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        })
    
        one_month_btn.isEnabled = false
        six_month_btn.isEnabled = true
        one_year_btn.isEnabled = true
        flag=1
        
    }
    
    @IBAction func six_month_btn(_ sender: UIButton) {
//        print("one_month btn")
        
        
        plan = 2245
        if(flag==1){
            UIView.animate(withDuration: 0, animations: {
                //self.basic.backgroundColor = .brown
                self.one_month_view.frame.origin.y += 10
                self.one_month_btn.frame.origin.y -= 10
                self.one_month_view.layer.borderWidth = 3
                self.one_month_view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.one_month_view.frame.size.height -= 20
                 self.one_month_view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
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
                 self.one_year_view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
            })
            
        }
        UIView.animate(withDuration: 0, animations: {
            //self.basic.backgroundColor = .brown
            self.six_month_view.frame.origin.y -= 10
            self.six_month_btn.frame.origin.y += 10
            self.six_month_view.layer.borderWidth = 3
            self.six_month_view.layer.borderColor = #colorLiteral(red: 0.2666666667, green: 0.462745098, blue: 0.4196078431, alpha: 1)
            self.six_month_view.frame.size.height += 20
            self.six_month_view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        })
        
        one_month_btn.isEnabled = true
        six_month_btn.isEnabled = false
        one_year_btn.isEnabled = true
        flag=2
    }
    
    @IBAction func one_year_btn(_ sender: UIButton) {
        print("one_YEAR btn")
        
        plan = 3592
        
        if(flag==1){
            UIView.animate(withDuration: 0, animations: {
                //self.basic.backgroundColor = .brown
                self.one_month_view.frame.origin.y += 10
                self.one_month_btn.frame.origin.y -= 10
                self.one_month_view.layer.borderWidth = 3
                self.one_month_view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.one_month_view.frame.size.height -= 20
                self.one_month_view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
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
                self.six_month_view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
            })
        }
        UIView.animate(withDuration: 0, animations: {
            //self.basic.backgroundColor = .brown
            self.one_year_view.frame.origin.y -= 10
            self.one_year_btn.frame.origin.y += 10
            self.one_year_view.layer.borderWidth = 3
            self.one_year_view.layer.borderColor = #colorLiteral(red: 0.2666666667, green: 0.462745098, blue: 0.4196078431, alpha: 1)
            self.one_year_view.frame.size.height += 20
            self.one_year_view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
        })
        
        one_month_btn.isEnabled = true
        six_month_btn.isEnabled = true
        one_year_btn.isEnabled = false
        flag=3
    }
    
   
    
    @IBAction func cont(_ sender: UIButton) {
        
        let vc = story.instantiateViewController(withIdentifier: "PayPal") as! PayPal
        
        vc.plan_price = plan
        
       
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        
        removeAnimate()
    }
    
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}
