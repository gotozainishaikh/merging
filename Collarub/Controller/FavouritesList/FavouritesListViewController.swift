//
//  FavouritesListViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 17/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import SDWebImage
import SwipeCellKit
import CoreData
import Alamofire
import SwiftyJSON
import SVProgressHUD

class FavouritesListViewController: UIViewController {

    var model : [FavListModel] = [FavListModel]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
    let url = FixVariable()
    
    @IBOutlet weak var favTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favTableView.tableFooterView = UIView()
      // addBtnNav()
        //setNavigationBar()
       // uiNavegationImage()

        // Do any additional setup after loading the view.
        retriveData()
        //MARK: Register table.nib file
        
        favTableView.register(UINib(nibName: "FavCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))

    }
    
    func retriveData() {
        
            let results : NSArray = try! context.fetch(request) as NSArray
            
            let res = results[0] as! NSManagedObject
            
            var id : String = res.value(forKey: "user_id") as! String
            
            print("\(id)")
            
            
            let parameters : [String:String] = [
                
                "user_id": id
                
            ]
            
            Alamofire.request("\(self.url.weburl)/select_user_fav_list.php", method: .get, parameters: parameters).responseJSON { (response) in
                SVProgressHUD.show(withStatus: "Connecting to server")
                if response.result.isSuccess {
                    
                    SVProgressHUD.dismiss()
                    
                    let dataJSON : JSON = JSON(response.result.value!)
                    
//                    let calender = NSCalendar.current
//                    //      let components = calender.component([.day, .month, .year], from: date)
//                    //calender.component([.day, .month, .year], from: <#T##Date#>)
//                    let year = calender.component(.year, from: date)
//                    let month = calender.component(.month, from: date)
//                    let day = calender.component(.day, from: date)
//
//
//                    print(year)
//                    print(month)
//                    print(day)
                    
                    print(dataJSON)
                    if dataJSON.count < 1 {
                        self.model.removeAll()
                        self.favTableView.reloadData()
                    }
                    self.model.removeAll()
                    
                    for item in 0..<dataJSON.count {
                        
                        let para : [String:Int] = [
                            "id" : dataJSON[item]["collaboration_id"].intValue
                        ]
                        Alamofire.request("\(self.url.weburl)/collabrubImages.php", method: .get, parameters: para).responseJSON { (response) in
                            
                            if response.result.isSuccess {
                                
                                let dataJSON1 : JSON = JSON(response.result.value!)
                                // let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                                //                            print(dataJSON[item])
                                //                             print(dataJSON1)
                                
                                let statusModel = FavListModel()
                                
                                statusModel.announcementImage = dataJSON1[0]["img_url"].stringValue
                                statusModel.title = dataJSON[item]["collaboration_name"].stringValue
                                statusModel.companyName = dataJSON[item]["company_name"].stringValue
                                statusModel.location = dataJSON[item]["address"].stringValue
                                statusModel.productImage = [dataJSON1[0]["img_url"].stringValue,dataJSON1[1]["img_url"].stringValue,dataJSON1[2]["img_url"].stringValue]
                                statusModel.palceImages = ["",""]
                                statusModel.reviews = ["",""]
                                statusModel.date = dataJSON[item]["date"].stringValue
                                statusModel.description = dataJSON[item]["descriptions"].stringValue
                                statusModel.collaborattionTerms = dataJSON[item]["collaboration_terms"].stringValue
                                statusModel.avalaibility = ""
                                statusModel.selectedNumOfFollowers = dataJSON[item]["followers_limit"].stringValue
                                //                            statusModel.lat = dataJSON[item]["lat"].doubleValue
                                //                            statusModel.long = dataJSON[item]["longg"].doubleValue
                                statusModel.partner_id = dataJSON[item]["partner_id"].stringValue
                                statusModel.collaboration_id = dataJSON[item]["collaboration_id"].stringValue
                                statusModel.status = dataJSON[item]["subscribe_status"].intValue
                                
                                self.model.append(statusModel)
                                //   SVProgressHUD.dismiss()
                                
                            }else {
                                print("error not get in first")
                            }
                            
                            //    print("count \(self.model.count)")
                            // SVProgressHUD.dismiss()
                            self.favTableView.reloadData()
                            
                        }
                        
                        
                    }
                    
                    //                if dataJSON["Status"] == "failed" {
                    //                    self.model.removeAll()
                    //                    self.statusTable.re
                    //                }
                    //
                    
                }else {
                    print("Error in fetching data")
                }
                
            }
            
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favTableView.reloadData()
    }
    
    @objc func backAction(){
        //print("Back Button Clicked")
        dismiss(animated: true, completion: nil)
    }
    
//    func addBtnNav(){
//                let button1 = UIBarButtonItem(image: UIImage(named: "togglt"), style: .plain, target: self, action: #selector(action))
//                self.navigationItem.leftBarButtonItem = button1
//                let button2 = UIBarButtonItem(image: UIImage(named: "bell-icon"), style: .plain, target: self, action: #selector(actionFavList))
//                self.navigationItem.rightBarButtonItem = button2
//                let logoImage:UIImage = UIImage(named: "logo_img")!
//                self.navigationItem.titleView = UIImageView(image: logoImage)
//
//    }
    
//    func setNavigationBar() {
//        let screenSize: CGRect = UIScreen.main.bounds
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 64))
//        let navItem = UINavigationItem(title: "")
//        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
//        //let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(action))
//        let button1 = UIBarButtonItem(image: UIImage(named: "togglt"), style: .plain, target: self, action: #selector(action))
//        navItem.leftBarButtonItem = button1
//        let button2 = UIBarButtonItem(image: UIImage(named: "bell-icon"), style: .plain, target: self, action: #selector(actionFavList))
//        navItem.rightBarButtonItem = button2
//        let logoImage:UIImage = UIImage(named: "logo_img")!
//        navItem.titleView = UIImageView(image: logoImage)
//        navBar.setItems([navItem], animated: false)
//        self.view.addSubview(navBar)
//    }
    
//    func uiNavegationImage(){
//        let logoImage:UIImage = UIImage(named: "logo_img")!
//        self.navigationItem.titleView = UIImageView(image: logoImage)
//    }
    
    //MARK: navigation click functions
    
//    @objc func action(){
//        let story = UIStoryboard(name: "Main", bundle: nil)
//        let vc = story.instantiateViewController(withIdentifier: "sideMenuNav")
//        present(vc, animated: true, completion: nil)
//    }
    
    @objc func actionFavList(){
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "FavList")
        present(vc, animated: true, completion: nil)
        
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

extension FavouritesListViewController : UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
         //   self.updateData(at: indexPath)
            
            
            
            let results : NSArray = try! self.context.fetch(self.request) as NSArray
            
            let res = results[0] as! NSManagedObject
            
            var id : String = res.value(forKey: "user_id") as! String
            
            print("\(id)")
            //print(indexPath.row)
            
            print(self.model[indexPath.row].collaboration_id)
           
            if let idd : String = self.model[indexPath.row].collaboration_id {
            
            let parameters : [String:String] = [

                "user_id": id,
                "collaboration_id" : idd

            ]

            Alamofire.request("\(self.url.weburl)/delete_fav_collaboration.php", method: .get, parameters: parameters).responseJSON { (response) in

                if response.result.isSuccess {

                    let dataJSON : JSON = JSON(response.result.value!)

                    print(dataJSON)
                   // self.model.remove(at: indexPath.row)
                    

                }
            }
                self.model.remove(at: indexPath.row)
                self.favTableView.reloadData()
            //    tableView.reloadData()
                
            }
            
           print("delete")
            
       //  self.model.remove(at: indexPath.row)
        }
        
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
        
        
    }
    
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        return options
//    }
//
    
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .border
//        return options
//    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavCellTableViewCell
        
        cell.usrImg.sd_setImage(with: URL(string: model[indexPath.row].announcementImage))
        cell.advertisementTitle.text = model[indexPath.row].title
        cell.advertisementDetails.text = model[indexPath.row].description
        
        
        cell.delegate = self
        //Image Round
        cell.usrImg.layer.cornerRadius = cell.usrImg.frame.size.width/2
        cell.usrImg.clipsToBounds = true
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favIdentifier" {
            let destinationVC = segue.destination as! LocalDetailsViewController
            destinationVC.favArray = (sender as? FavListModel!)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.performSegue(withIdentifier: "favIdentifier", sender: model[(indexPath.row)])
        
        print(self.model[indexPath.row].collaboration_id)
    }
   
    
}

