//
//  ReviewViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 18/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData
import Alamofire
import SwiftyJSON


class ReviewViewController: UIViewController {

    let story = UIStoryboard(name: "Main", bundle: nil)
    var model : [ReviewModel] = [ReviewModel]()
   // var id : String = ""
    let url = FixVariable()
    var refresher:UIRefreshControl!
    
    @IBOutlet weak var reviewTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      //  configuratioTable()
        reviewTable.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewCell")
        retriveData()
        reviewTable.allowsSelection = false
        reviewTable.separatorStyle = .none
        
        uiNavegationImage()
        
        let button2 = UIBarButtonItem(image: UIImage(named: "bell-icon"), style: .plain, target: self, action: #selector(actionFavList))
        
        self.navigationItem.rightBarButtonItem  = button2
        
        
        
        self.refresher = UIRefreshControl()
        self.reviewTable!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.gray
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.reviewTable!.addSubview(refresher)
        
        
        
    }
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    
    @objc func actionFavList(){
        
        let vc = story.instantiateViewController(withIdentifier: "FavList")
        present(vc, animated: true, completion: nil)
        
        
    }
    
    @objc func loadData() {
        //code to execute during refresher
        
        retriveData()
        stopRefresher()         //Call this to stop refresher
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    
    
    func retriveData(){
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
        
        
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        var id : String = res.value(forKey: "user_id") as! String
        
        print("\(id)")
        
        
        let parameters : [String:String] = [
            "user_id": id
            
        ]
        
        Alamofire.request("\(self.url.weburl)/user_reviews_by_partner.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let dataJSON : JSON = JSON(response.result.value!)
                
             //   print(dataJSON)
                self.model.removeAll()
                
                for item in 0..<dataJSON.count {
                    
                    let reviewModel = ReviewModel()
            
                    reviewModel.reviewerImg = dataJSON[item]["partner_img"].stringValue
                    reviewModel.reviewerName = dataJSON[item]["partner_name"].stringValue
                    reviewModel.reviewRate = dataJSON[item]["ratings"].doubleValue
                    reviewModel.review = dataJSON[item]["review_description"].stringValue
                    
                    self.model.append(reviewModel)
                    
                    self.reviewTable.reloadData()
                }
                
                
            }else {
                print("Error in fetching data")
            }
            
        }
//
//        let reviewModel = ReviewModel()
//
//        reviewModel.reviewerImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqThS-tzy5K_w6Q81eGHAQwYNy9PGWKoKv7TLCPtcjUI4njoecpA"
//        reviewModel.reviewerName = "Amelia Emma"
//        reviewModel.reviewRate = 2.5
//        reviewModel.review = "orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
//
//        let reviewModel1 = ReviewModel()
//
//        reviewModel1.reviewerImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBOwO7yyg1xLxepxSlu1aVHK6m-KqmPLfM_g8nwDLla9vXhhkV5g"
//        reviewModel1.reviewerName = "Jack Richard"
//        reviewModel1.reviewRate = 3.8
//        reviewModel1.review = "orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
//
//        let reviewModel2 = ReviewModel()
//
//        reviewModel2.reviewerImg = "https://www.incimages.com/uploaded_files/image/100x100/IN0318COL02_350484.jpg"
//        reviewModel2.reviewerName = "William Charles"
//        reviewModel2.reviewRate = 3.1
//        reviewModel2.review = "orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
//
//        let reviewModel3 = ReviewModel()
//
//        reviewModel3.reviewerImg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9OouvFgOCFFrFwrFWh_XIvhyIWDzVc6s7PERsOn7T-uOYg-nt"
//        reviewModel3.reviewerName = "Oliver John"
//        reviewModel3.reviewRate = 4.9
//        reviewModel3.review = "orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
//
//
//        let reviewModel4 = ReviewModel()
//
//        reviewModel4.reviewerImg = "https://media.npr.org/about/people/bios/biophotos/flangfitt_sq-430b1c2af135c301f89d20b683e8b53f0369d4f8-s100-c85.jpg"
//        reviewModel4.reviewerName = "Oscar David"
//        reviewModel4.reviewRate = 1.4
//        reviewModel4.review = "orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
//
//        let reviewModel5 = ReviewModel()
//
//        reviewModel5.reviewerImg = "https://www.testmybrain.org/images/test_thumbs/Famous+Faces.png"
//        reviewModel5.reviewerName = "Sophie James"
//        reviewModel5.reviewRate = 2.4
//        reviewModel5.review = "orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
//
//        let reviewModel6 = ReviewModel()
//
//        reviewModel6.reviewerImg = "https://hips.hearstapps.com/elleuk.cdnds.net/17/06/1600x1600/square-1486647398-aarontaylorjohnson.jpg?resize=100:*"
//        reviewModel6.reviewerName = "Smith Thomas"
//        reviewModel6.reviewRate = 2.0
//        reviewModel6.review = "orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
//
//        model.append(reviewModel)
//        model.append(reviewModel1)
//        model.append(reviewModel2)
//        model.append(reviewModel3)
//        model.append(reviewModel4)
//        model.append(reviewModel5)
//        model.append(reviewModel6)
        
    }

//    func configuratioTable() {
//        reviewTable.rowHeight = UITableView.automaticDimension
//        reviewTable.estimatedRowHeight = 300.0
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
        
        cell.reviewerImg.sd_setImage(with: URL(string: model[indexPath.row].reviewerImg) )
        cell.reviewerName.text = model[indexPath.row].reviewerName
        cell.ratingLabel.text = "\(model[indexPath.row].reviewRate) - 5"
        cell.ratings(ratingValue: model[indexPath.row].reviewRate)
        
    //Image Round
       cell.reviewerImg.layer.cornerRadius = cell.reviewerImg.frame.size.width/2
        cell.reviewerImg.clipsToBounds = true
        
        
        
        
        return cell
    }
    
    
    
}


