//
//  FindInfluencerViewController.swift
//  Collarub
//
//  Created by mac on 09/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class FindInfluencerViewController: UIViewController {

    var model : [FindInfluencerModel] = [FindInfluencerModel]()
    let url = FixVariable()
    
    @IBOutlet weak var findInfluencerTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

         NotificationCenter.default.addObserver(self, selector: #selector(loadList(req_notification:)), name: NSNotification.Name(rawValue: "hire"), object: nil)
        
        findInfluencerTable.register(UINib(nibName: "FindInfluencerTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // retriveData()
        findInfluencerTable.allowsSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retrieveData()
    }
    

    @objc func loadList(req_notification: NSNotification) {
        
        var req_id : String = ""
        
        if let dict = req_notification.userInfo as NSDictionary? {
            if let id = dict["req_id"] as? String{
                print("id="+id)
                // print("hosp_id="+hosp_id!)
                req_id = id
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "campaignList")
                present(vc!, animated: true, completion: nil)
            }
            
            
            
        }
    }
            
    @IBAction func filterClick(_ sender: UIButton) {
        let stroy = UIStoryboard(name: "Main", bundle: nil)
        let vc = stroy.instantiateViewController(withIdentifier: "filterPopUp")
        
//        self.addChild(vc)
//        self.view.addSubview(vc.view)
//        vc.didMove(toParent: self)

        present(vc, animated: true, completion: nil)
    }
    
    func retrieveData() {
        
        Alamofire.request("\(self.url.weburl)/get_all_user.php", method: .get).responseJSON { (response) in
           // SVProgressHUD.show(withStatus: "Connecting to server")
            if response.result.isSuccess {
                
             //   SVProgressHUD.dismiss()
                
                let dataJSON : JSON = JSON(response.result.value!)
                
                print(dataJSON)
                for item in 0..<dataJSON.count {
                     let statusModel = FindInfluencerModel()
                    
                    statusModel.usrImg = dataJSON[item]["image_url"].stringValue
                    statusModel.usrname = dataJSON[item]["full_name"].stringValue
                    statusModel.engRate = dataJSON[item]["engagementRate"].stringValue
                    statusModel.totalFollowers = dataJSON[item]["followers"].stringValue
                    statusModel.totalFollowers = dataJSON[item]["followers"].stringValue
                    statusModel.user_id = dataJSON[item]["user_id"].stringValue
                    
                     self.model.append(statusModel)
                    self.findInfluencerTable.reloadData()
                }
            }
        }
    }
    

}


extension FindInfluencerViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FindInfluencerTableViewCell
        
        cell.usrImg.sd_setImage(with: URL(string: model[indexPath.row].usrImg))
        cell.influencerName.text = model[indexPath.row].usrname
        cell.totalFollowers.text = model[indexPath.row].totalFollowers
        cell.influencerEngRate.text = model[indexPath.row].engRate
        cell.req_id = model[indexPath.row].user_id
        //Image Round
        cell.usrImg.layer.cornerRadius = cell.usrImg.frame.size.width/2
        cell.usrImg.clipsToBounds = true
        
        cell.hireBtn.layer.borderColor = UIColor(named: "ThemeColor1")!.cgColor
        cell.hireBtn.layer.cornerRadius = 4
        cell.hireBtn.layer.borderWidth = 0.5
        return cell
    }
    
    
    
    
    
    
    
}

