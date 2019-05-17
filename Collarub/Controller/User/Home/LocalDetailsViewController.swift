//
//  LocalDetailsViewController.swift
//  Collarub
//
//  Created by Mac 1 on 10/17/1397 AP.
//  Copyright © 1397 Mac 1. All rights reserved.
//

import UIKit
import SDWebImage
import ImageSlideshow
import CoreData
import TTGSnackbar
import Alamofire
import SwiftyJSON
import Cosmos

class LocalDetailsViewController: UIViewController {

    
    //Alamofire
    let api = AlamofireApi()
    
    //base Url
    let base_url = FixVariable()
    
    //User_id
    var user_id : String!
    
    //User Type
    var user_type : String!
    
    //Collaboration Id
    var col_id = ""
    
    var isfav : String = ""
    
    var model : [ReviewModel] = [ReviewModel]()
    
    let story = UIStoryboard(name: "User", bundle: nil)
    
    var images = [InputSource]()
    
    
    //to_do
    var to_do_array:[Substring] = []
    var dont_do_array:[Substring] = []
    var bgt_value : String = ""
    
    @IBOutlet weak var isFavr: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableView2: UITableView!
    
    @IBOutlet weak var imgSlider: ImageSlideshow!
    
    @IBOutlet weak var reviewNmbr: UILabel!
    @IBOutlet weak var reviewRate: CosmosView!
    @IBOutlet weak var reviewDes: UILabel!
    @IBOutlet weak var reviewName: UILabel!
    @IBOutlet weak var reviewImg: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var advertisementTitle: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var expiry_date: UILabel!
    
    @IBOutlet weak var type_value: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var advertisementDescription: UILabel!
    @IBOutlet weak var engagement_rate: UILabel!
    
    @IBOutlet weak var content_type: UILabel!
    
    @IBOutlet weak var viewMORE: UIButton!
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var exp_level: UILabel!
    
    
    
    @IBOutlet weak var numOfFollowers: UILabel!
    
    @IBOutlet weak var ACCPTBUGT: UIButton!
    
    @IBAction func request_btn(_ sender: UIButton) {
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        var id : String = res.value(forKey: "user_id") as! String
        
        print("coredata_userId=\(id)")
        
        get_user_type{
            
            if(self.user_type == "1"){
                
                let vc = self.story.instantiateViewController(withIdentifier: "UpgradePopUP") as! UpgradePopUP
//                vc.user_id = id
//                
//                print("detailsArray?.collaboration_idabc=\(self.detailsArray?.collaboration_id)")
//                
//                if((self.detailsArray?.collaboration_id) != nil){
//                    print("detailsArray=\((self.detailsArray?.collaboration_id)!)")
//                    vc.campaign_id = String((self.detailsArray?.collaboration_id)!)
//                    
//                }
//                else if((self.modelCustom?.collaboration_id) != nil){
//                    print("modelCustom=\((self.modelCustom?.collaboration_id)!)")
//                    vc.campaign_id = String((self.modelCustom?.collaboration_id)!)
//                    
//                }
                
                
                self.addChild(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
            }
            else{
                
                if((self.detailsArray?.collaboration_id) != nil){
                   self.col_id = String((self.detailsArray?.collaboration_id)!)
                }
                else if((self.modelCustom?.collaboration_id) != nil){
                   
                    self.col_id = String((self.modelCustom?.collaboration_id)!)
                }
                
                print("col_id=\(self.col_id)")
                let url = "\(self.base_url.weburl)/paid_user_request.php"
                self.api.alamofireApiWithParams(url: url
                , parameters: ["user_id":self.user_id,"campaign_id":self.col_id]){
                    json in
                    
                    print("PAID\(json["Status"].stringValue)")
                    
                    let vc = self.story.instantiateViewController(withIdentifier: "mainScr") as! MainScreenViewController
                   
                    self.addChild(vc)
                    self.view.addSubview(vc.view)
                    vc.didMove(toParent: self)
                    let snackbar = TTGSnackbar(message: json["Status"].stringValue, duration: .short)
                    snackbar.show()
                }
                
               
                
            }
        }
        
        
    }
    
    
    var detailsArray : LocalModel?
    var onlineArray : OnlineModel?
    var statArray : StatusTableModel?
    var modelCustom : customAnnoation?
    var favArray : FavListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(req_notification:)), name: NSNotification.Name(rawValue: "bgt_val"), object: nil)
        
        
        let logoutBarButtonItem = UIBarButtonItem(image:UIImage(named: "share"), style: .done, target: self, action: #selector(sharing))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        

     //   print("idd :: \(detailsArray?.isFav)")
        if detailsArray?.isFav != nil {
            if (detailsArray?.isFav)! == "1" {
            isFavr.setImage(UIImage(named: "hearts"), for: .normal)
            }
        }
        else if onlineArray?.isFav != nil {
            if (onlineArray?.isFav)! == "1" {
            isFavr.setImage(UIImage(named: "hearts"), for: .normal)
                
            }
        }
        
        
        
        
        retriveData()
        tableView.dataSource = self
        tableView.delegate = self
       
        
        tableView2.dataSource = self
        tableView2.delegate = self
      
        //to_do_array = ["a","b","c"]
        
//        if detailsArray?.wht_thy_hav_to_do != nil {
//
//        let to_do = (detailsArray?.wht_thy_hav_to_do)!
//        to_do_array = to_do.split(separator: "\n")
//        print("to_do_list=\(to_do_array)")
//        //tableView.reloadData()
//        }else if onlineArray?.wht_thy_hav_to_do != nil {
//            let to_do = (onlineArray?.wht_thy_hav_to_do)!
//            to_do_array = to_do.split(separator: "\n")
//            print("to_do_list=\(to_do_array)")
//        }
        
//         if detailsArray?.wht_wont_hav_to != nil {
//        let dont_do = (detailsArray?.wht_wont_hav_to)!
//        dont_do_array = dont_do.split(separator: "\n")
//        print("dont_do_list=\(dont_do_array)")
//         }else if onlineArray?.wht_wont_hav_to != nil {
//            let dont_do = (onlineArray?.wht_wont_hav_to)!
//            dont_do_array = dont_do.split(separator: "\n")
//            print("dont_do_list=\(dont_do_array)")
//        }
        
        ACCPTBUGT.isHidden = true
        fetch_coreData()
        localDetails()

        //Image Silder
        imgSlider.slideshowInterval = 5.0
        imgSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imgSlider.contentScaleMode = UIView.ContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
       
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.2156862745, green: 0.6784313725, blue: 0.5882352941, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        imgSlider.pageIndicator = pageControl
        
     
        
        
        imgSlider.setImageInputs(images)
       // print("detailsArray?.collaboration_id\((detailsArray?.collaboration_id))!")
      //  print("Accep_budget_check=\((detailsArray?.Accep_budget_check)!)")
       
       
        
        uiNavegationImage()
        //print("description=\((detailsArray?.description)!)")
   //     UINavigationBar.appearance().tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        // Do any additional setup after loading the view.
    }
    
    @objc func sharing(){
        print("clicked")
        let textToShare = "Check out this Campaign 'Web link' or download the App from 'Website link'"
        
        if let myWebsite = NSURL(string: "http://www.collaborup.com/") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @objc func loadList(req_notification: NSNotification) {
        
      
        if let dict = req_notification.userInfo as NSDictionary? {
            if let id = dict["value"] as? String{
                print("id="+id)
                // print("hosp_id="+hosp_id!)
                bgt_value = id
            }
            
            print("bgt_val :: \(bgt_value)")
        }
    }
    
    @IBAction func acp_btn(_ sender: UIButton) {
        
        print("acpt_btn")
        var val = ""
        var coll_id = ""
        
        if (detailsArray != nil) {
            val = (detailsArray?.budget_value)!
            coll_id = (detailsArray?.collaboration_id)!
        }else if (onlineArray != nil){
            val = (onlineArray?.budget_value)!
            coll_id = (onlineArray?.collaboration_id)!
        }else if (statArray != nil){
            val = (statArray?.budget_value)!
            coll_id = (statArray?.collaboration_id)!
        }else if (modelCustom != nil ){
            val = (modelCustom?.budget_value)!
            coll_id = (modelCustom?.collaboration_id)!
        }
        
        let vc = story.instantiateViewController(withIdentifier: "budget_pop") as! AcceptBudgetViewController
        
        vc.val = val
        vc.user_id = user_id
        vc.col_id = coll_id
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        
    }
    
    
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    var isLike = false
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
    let url = FixVariable()
    
    @IBAction func favBtn(_ sender: UIButton) {
        
        
        sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: .allowUserInteraction,
                       animations: {
                        sender.transform = .identity
                        if self.isLike {
                            sender.setImage(UIImage(named: "like"), for: .normal)
                            self.isLike = false
                        }else {
                            sender.setImage(UIImage(named: "hearts"), for: .normal)
                            self.isLike = true
                        }
        },
                       completion: { finished in
                        // self.animateButton()
                        let results : NSArray = try! self.context.fetch(self.request) as NSArray
                        
                        let res = results[0] as! NSManagedObject
                        
                        var id : String = res.value(forKey: "user_id") as! String
                        
                        
                        print(self.detailsArray?.collaboration_id)
                        
                        var c_id = ""
                        if self.detailsArray != nil {
                            c_id = (self.detailsArray?.collaboration_id)!
                        }
                        
                       else if self.onlineArray != nil {
                            c_id = (self.onlineArray?.collaboration_id)!
                        }
                        
                        else if self.modelCustom != nil {
                            c_id = (self.modelCustom?.collaboration_id)!
                        }
                        
                        let parameters : [String:String] = [
                            "user_id": id,
                            "collaboration_id": c_id
                            
                        ]
                        
                        
                        Alamofire.request("\(self.url.weburl)/favourite_list_of_user.php", method: .get, parameters: parameters).responseJSON { (response) in
                            
                            if response.result.isSuccess {
                                
                                let dataJSON : JSON = JSON(response.result.value!)
                                
                                print(dataJSON)
                            }
                        }
                        //    myfunc()
                        
                        
        }
        )
        
        
    }
    
    

    func detail(array:[AnyClass]){
        
    }
    
    func localDetails(){
        
        
        if (detailsArray != nil) {
            
//            image1.sd_setImage(with: URL(string: (detailsArray?.productImage[0])!))
//            image2.sd_setImage(with: URL(string: (detailsArray?.productImage[1])!))
//            image3.sd_setImage(with: URL(string: (detailsArray?.productImage[2])!))
            //advertisementTitle.text = detailsArray?.title
          print("detailsArray?.productImage=\(detailsArray?.productImage.count)")
            for item in (detailsArray?.productImage)! as [String]{
                if(item != ""){
            
                    images.append(AlamofireSource(urlString:item)!)

                }
            }
            
            if((detailsArray?.Accep_budget_check)! == "Accept Budget"){
                
                get_user_type {
                    if self.user_type == "2" {
                        self.ACCPTBUGT.isHidden = false
                        
                        self.ACCPTBUGT.layer.borderColor = UIColor(named: "themecolor4")?.cgColor
                        self.ACCPTBUGT.layer.borderWidth = 0.5
                    }
                }
                
            }
            
            let to_do = (detailsArray?.wht_thy_hav_to_do)!
            to_do_array = to_do.split(separator: "\n")
            print("to_do_list=\(to_do_array)")
            
            let dont_do = (detailsArray?.wht_wont_hav_to)!
            dont_do_array = dont_do.split(separator: "\n")
            print("dont_do_list=\(dont_do_array)")
            
            companyName.text = detailsArray?.companyName
            location.text = "\((detailsArray?.required_city)!),\((detailsArray?.required_region)!)"
            date.text = "Date:\((detailsArray?.date)!) "
            expiry_date.text = "Expiry:\((detailsArray?.expiry_date)!)"
            advertisementDescription.text = detailsArray?.description
            
            
            if((detailsArray?.type)! == "exchange") || ((detailsArray?.type)! == "Exchange"){
                
                type.text = "EXCHANGE:"
                type_value.text = (detailsArray?.budget_value)!
                
            }
            else if((detailsArray?.type)! == "discount"){
                
                type.text = "DISCOUNT:"
                type_value.text = "\((detailsArray?.budget_value)!) | \((detailsArray?.discount_field)!)"
                
            }
            
            content_type.text = (detailsArray?.content_type)!
            engagement_rate.text = detailsArray?.engagement_rate
            rating.text = (detailsArray?.rating)!
            gender.text = (detailsArray?.user_gender)!
            exp_level.text = "\((detailsArray?.min_user_exp_level)!)/10"
            
            
            //collaborationTerm.text = detailsArray?.collaborattionTerms
            //numOfFollowers.text = detailsArray?.selectedNumOfFollowers
        }
        else if (onlineArray != nil){
            print("detailsArray?.productImage=\(onlineArray?.productImage.count)")
            for item in (onlineArray?.productImage)! as [String]{
                if(item != ""){
                    
                    images.append(AlamofireSource(urlString:item)!)
                    
                }
            }
            
            if((onlineArray?.Accep_budget_check)! == "Accept Budget"){
                get_user_type {
                    if self.user_type == "2" {
                        self.ACCPTBUGT.isHidden = false
                        
                        self.ACCPTBUGT.layer.borderColor = UIColor(named: "themecolor4")?.cgColor
                        self.ACCPTBUGT.layer.borderWidth = 0.5
                    }
                }
            }
            
            let to_do = (onlineArray?.wht_thy_hav_to_do)!
            to_do_array = to_do.split(separator: "\n")
            print("to_do_list=\(to_do_array)")
            
            let dont_do = (onlineArray?.wht_wont_hav_to)!
            dont_do_array = dont_do.split(separator: "\n")
            print("dont_do_list=\(dont_do_array)")
            
            companyName.text = onlineArray?.companyName
            location.text = "\((onlineArray?.required_city)!),\((onlineArray?.required_region)!)"
            date.text = "Date:\((onlineArray?.date)!) "
            expiry_date.text = "Expiry:\((onlineArray?.expiry_date)!)"
            advertisementDescription.text = onlineArray?.description
            
            if((onlineArray?.type)! == "exchange") || ((onlineArray?.type)! == "Exchange"){
                
                type.text = "EXCHANGE:"
                type_value.text = (onlineArray?.budget_value)!
                
            }
            else if((onlineArray?.type)! == "discount"){
                
                type.text = "DISCOUNT:"
                type_value.text = "\((onlineArray?.budget_value)!) | \((onlineArray?.discount_field)!)"
                
            }
            
            content_type.text = (onlineArray?.content_type)!
            engagement_rate.text = onlineArray?.engagement_rate
            rating.text = (onlineArray?.rating)!
            gender.text = (onlineArray?.user_gender)!
            exp_level.text = "\((onlineArray?.min_user_exp_level)!)/10"
            
        }
        else if (modelCustom != nil){
            
            for item in (modelCustom?.productImage)! as [String]{
                if(item != ""){
                    
                    images.append(AlamofireSource(urlString:item)!)
                    
                }
            }
            
            let to_do = (modelCustom?.wht_thy_hav_to_do)!
            to_do_array = to_do.split(separator: "\n")
            print("to_do_list=\(to_do_array)")
            
            let dont_do = (modelCustom?.wht_wont_hav_to)!
            dont_do_array = dont_do.split(separator: "\n")
            print("dont_do_list=\(dont_do_array)")
            
            
            companyName.text = modelCustom?.companyName
            location.text = "\((modelCustom?.required_city)!),\((modelCustom?.required_region)!)"
            date.text = "Date:\((modelCustom?.date)!) "
            expiry_date.text = "Expiry:\((modelCustom?.expiry_date)!)"
            advertisementDescription.text = modelCustom?.description1
            
            if((modelCustom?.type)! == "exchange") || ((modelCustom?.type)! == "Exchange"){
                
                type.text = "EXCHANGE:"
                type_value.text = (modelCustom?.budget_value)!
                
            }
            else if((modelCustom?.type)! == "discount"){
                
                type.text = "DISCOUNT:"
                type_value.text = "\((modelCustom?.budget_value)!) | \((modelCustom?.discount_field)!)"
                
            }
            
            content_type.text = (modelCustom?.content_type)!
            engagement_rate.text = modelCustom?.engagement_rate
            rating.text = (modelCustom?.rating)!
            gender.text = (modelCustom?.user_gender)!
            exp_level.text = "\((modelCustom?.min_user_exp_level)!)/10"
        }
        else if (statArray != nil){
            
          
            print("detailsArray?.productImage=\(statArray?.productImage.count)")
            for item in (statArray?.productImage)! as [String]{
                if(item != ""){
                    
                    images.append(AlamofireSource(urlString:item)!)
                    
                }
            }
            
            companyName.text = statArray?.companyName
            location.text = "\((statArray?.required_city)!),\((statArray?.required_region)!)"
            date.text = "Date:\((statArray?.date)!) "
            expiry_date.text = "Expiry:\((statArray?.expiry_date)!)"
            advertisementDescription.text = statArray?.description
            
            if((statArray?.type)! == "exchange") || ((statArray?.type)! == "Exchange"){
                
                type.text = "EXCHANGE:"
                type_value.text = (statArray?.budget_value)!
                
            }
            else if((statArray?.type)! == "discount"){
                
                type.text = "DISCOUNT:"
                type_value.text = "\((statArray?.budget_value)!) | \((statArray?.discount_field)!)"
                
            }
            
            content_type.text = (statArray?.content_type)!
            engagement_rate.text = statArray?.engagement_rate
            rating.text = (statArray?.rating)!
            gender.text = (statArray?.user_gender)!
            exp_level.text = "\((statArray?.min_user_exp_level)!)/10"
            
            
            //collaborationTerm.text = detailsArray?.collaborattionTerms
            //numOfFollowers.text = detailsArray?.selectedNumOfFollowers
        }
//        else if (favArray != nil) {
//
//            image1.sd_setImage(with: URL(string: (favArray?.productImage[0])!))
//            image2.sd_setImage(with: URL(string: (favArray?.productImage[1])!))
//            image3.sd_setImage(with: URL(string: (favArray?.productImage[2])!))
//            advertisementTitle.text = favArray?.title
//            companyName.text = favArray?.companyName
//            location.text = favArray?.location
//            date.text = favArray?.date
//            advertisementDescription.text = favArray?.description
//            collaborationTerm.text = favArray?.collaborattionTerms
//            numOfFollowers.text = favArray?.selectedNumOfFollowers
//
//        }
        
    }
    
    func fetch_coreData(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
        
        let results : NSArray = try! context.fetch(request) as NSArray
        
        let res = results[0] as! NSManagedObject
        
        self.user_id = res.value(forKey: "user_id") as! String

    }

    func get_user_type(completion: @escaping () -> Void){
        
        let url = "\(base_url.weburl)/get_user_type.php"
        api.alamofireApiWithParams(url: url
        , parameters: ["user_id":user_id]){
            json in
            
            self.user_type = json[0]["user_type"].stringValue
            
            completion()
        }
        
    }
    @IBAction func viewMore(_ sender: Any) {
        let vc = story.instantiateViewController(withIdentifier: "detailReview") as! DetailReviewViewController
        
        
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}


extension LocalDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("to_do_array.count=\(to_do_array.count)")
//        return to_do_array.count
        
        
        var count:Int?
        
        if tableView == self.tableView {
            count = to_do_array.count
        }
        
        if tableView == self.tableView2 {
            count =  dont_do_array.count
        }
        
        return count!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "To_do_cell") as! To_do_cell
//
//        cell.to_do_labele.text = String(to_do_array[indexPath.row])
//
//        return cell
        
        var nul_cell:UITableViewCell?
        
        if tableView == self.tableView {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "To_do_cell") as! To_do_cell
        
            cell.to_do_labele.text = String(to_do_array[indexPath.row])
    
            return cell
        
        }
        
        if tableView == self.tableView2 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "dont_do_cell") as! dont_do_cell

            cell.label.text = String(dont_do_array[indexPath.row])

            return cell

        }
        
//        if tableView == self.tableView2 {
//            cell = tableView.dequeueReusableCellWithIdentifier("dont_do_cell", forIndexPath: indexPath)
//            let previewDetail = sampleData1[indexPath.row]
//            cell!.textLabel!.text = previewDetail.title
//
//        }
        
        
        return nul_cell!
        //return cell!
    }
    
    
    func retriveData(){
        
      
        var p_id = ""
        if detailsArray != nil {
            p_id = (detailsArray?.partner_id)!
        }else if modelCustom != nil {
        }else if onlineArray != nil {
             p_id = (onlineArray?.partner_id)!
        }
        else if modelCustom != nil {
            p_id = (modelCustom?.partner_id)!
        }
       
        let parameters : [String:String] = [
            "partner_id": p_id
            
        ]
        
        print("p_id :: \(p_id)")
        Alamofire.request("\(self.base_url.weburl)/user_reviews_by_partner.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let dataJSON : JSON = JSON(response.result.value!)
                
                if dataJSON["Status"] == "failed" {
                    print("NO Data")
                }else {
                //   print(dataJSON)
                self.model.removeAll()
                
                for item in 0..<dataJSON.count {
                    
                    let reviewModel = ReviewModel()
                    
                    reviewModel.reviewerImg = dataJSON[item]["partner_img"].stringValue
                    reviewModel.reviewerName = dataJSON[item]["partner_name"].stringValue
                    reviewModel.reviewRate = dataJSON[item]["ratings"].doubleValue
                    reviewModel.review = dataJSON[item]["review_description"].stringValue
                    
                    
                    self.model.append(reviewModel)
                    print("\(reviewModel.reviewerName)")
                   // self.tableView.reloadData()
                }
                    
                    self.reviewName.text = self.model[0].reviewerName
                    self.reviewDes.text = self.model[0].review
                    self.reviewRate.rating = self.model[0].reviewRate
                    self.reviewNmbr.text = "\(Int(self.model[0].reviewRate)) / 5"
                    self.reviewImg.sd_setImage(with: URL(string: self.model[0].reviewerImg))
                    print("totl :: \(self.model.count)")
                    if self.model.count < 0 {
                        self.viewMORE.isHidden = true
                    }else {
                        self.viewMORE.isHidden = false
                    }
                
                    //Image Round
                    self.reviewImg.layer.cornerRadius = self.reviewImg.frame.size.width/2
                    self.reviewImg.clipsToBounds = true
                
            }
            }else {
                print("Error in fetching data")
            }
            
            
        }
        
        
    }
    
    
    
    
}
