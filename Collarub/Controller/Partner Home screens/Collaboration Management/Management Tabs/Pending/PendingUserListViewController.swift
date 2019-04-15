//
//  PendingUserListViewController.swift
//  Collarub
//
//  Created by mac on 13/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit

class PendingUserListViewController: UIViewController {

    
    var model : [FindInfluencerModel] = [FindInfluencerModel]()
    var usr_id : String = ""
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "PendingUserListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
     
        print("use id is \(usr_id)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        print("hello")
    }
    
}


extension PendingUserListViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PendingUserListTableViewCell
        
        //Image Round
                cell.usrImg.layer.cornerRadius = cell.usrImg.frame.size.width/2
                cell.usrImg.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "pendingClick") as! PendingPopUpViewController
        
       // vc.model = model
                self.addChild(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
    }
}
