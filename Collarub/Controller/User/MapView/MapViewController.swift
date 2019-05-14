//
//  MapViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 10/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import MapKit
import PopupWindow
import SDWebImage
import Alamofire
import SwiftyJSON
import SVProgressHUD

class MapViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {

    
    let url = FixVariable()
    var modelAnnoation = customAnnoation()
    
    @IBOutlet weak var numOfFollowers: UILabel!
    @IBOutlet weak var imgCollabrub: UIImageView!
    @IBOutlet weak var collabrubTitle: UILabel!
    @IBOutlet weak var collabrubDescrip: UILabel!
    @IBOutlet weak var btnCollabrub: UIButton!
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    var model : [LocalModel] = [LocalModel]()
    var modelElement = LocalModel()
    @IBOutlet weak var searchbar: UISearchBar!
    let locations = [
        ["title": "Maji Hospital",    "latitude": 25.381930, "longitude": 68.373040],
        ["title": "Thandi Sarak", "latitude": 25.381930, "longitude": 68.373040],
        ["title": "Pervez Motors",     "latitude": 25.381930, "longitude": 68.373040],["title": "Madina Masjid",     "latitude": 25.381484, "longitude": 68.374286]
    ]

    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var otherLocation = CLLocationCoordinate2D()
    override func viewDidLoad() {
        super.viewDidLoad()

        myView.isHidden = true
       
        
        //MARK: Calling retriving data function
        retriveData(){
            //print("model companyName=\(self.model[0].companyName)")
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        }
       
        //MARK: Calling nivagation bar image functions
        uiNavegationImage()
        
       // self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))
        
       // self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    @objc func backAction(){
        //print("Back Button Clicked")
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = locationManager.location?.coordinate {
            let center = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
            userLocation = center
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            //            mapView.removeAnnotation(mapView!.annotations)
            let annoation = MKPointAnnotation()
            annoation.coordinate = center
            
//            annoation.title = "Your Location"
//            mapView.addAnnotation(annoation)
            //
            //            var annotion = MKPointAnnotation()
            //            annotion.coordinate = CLLocationCoordinate2D(latitude: 25.381929, longitude: 68.373039)
            //            mapView.addAnnotation(annotion)
            //            annotion.title = "Second Location"
            //            mapView.addAnnotation(annotion)
            locationManager.stopUpdatingLocation()
            
            dropMarker(mymodel: model)
            //print("\(userLocation.latitude), \(userLocation.longitude)")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        
        activeSearch.start { (response, error) in
            if response == nil {
                print(error)
            }else {
                
                let searchAnnoation = MKPointAnnotation()
                self.mapView.removeAnnotation(searchAnnoation)
                let lat = response?.boundingRegion.center.latitude
                let long = response?.boundingRegion.center.longitude
                searchAnnoation.title = searchBar.text
                searchAnnoation.coordinate = CLLocationCoordinate2D(latitude: lat as! Double, longitude: long as! Double)
                self.mapView.addAnnotation(searchAnnoation)
                searchBar.resignFirstResponder()
                
            }
            
        }
    }
    
    func dropMarker(mymodel: [LocalModel]) {
//        for location in locations {
//            let annotations = MKPointAnnotation()
//            annotations.title = location["title"] as? String
//            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
//            mapView.addAnnotation(annotations)
//        }
        print("countmyModelcompanyName=\(mymodel[0].companyName)")
        print("countmyModellat=\(mymodel[0].lat)")
        print("countmyModellong=\(mymodel[0].long)")
        for var i in 0..<mymodel.count
        {
            let annotations = customAnnoation()
            annotations.title = (mymodel[i].title as? String)!
            annotations.coordinate = CLLocationCoordinate2D(latitude: mymodel[i].lat as! Double, longitude: mymodel[i].long as! Double)
            annotations.announcementImage = mymodel[i].announcementImage
            annotations.companyName = mymodel[i].companyName
            annotations.location = mymodel[i].location
            annotations.productImage = mymodel[i].productImage
            annotations.palceImages = mymodel[i].palceImages
            annotations.reviews = mymodel[i].reviews
            annotations.date = mymodel[i].date
            annotations.description1 = mymodel[i].description
            annotations.collaborattionTerms = mymodel[i].collaborattionTerms
            annotations.avalaibility = mymodel[i].avalaibility
            annotations.selectedNumOfFollowers = mymodel[i].selectedNumOfFollowers
            annotations.lat = mymodel[i].lat
            annotations.long = mymodel[i].long
            
            
            annotations.collaboration_id = mymodel[i].collaboration_id
            annotations.expiry_date = mymodel[i].expiry_date
            annotations.Accep_budget_check  =  mymodel[i].Accep_budget_check
            annotations.budget_value  = mymodel[i].budget_value
            annotations.type  = mymodel[i].type
            annotations.discount_field  = mymodel[i].discount_field
            annotations.content_type  = mymodel[i].content_type
            annotations.required_city  = mymodel[i].required_city
            annotations.required_region  = mymodel[i].required_region
            annotations.engagement_rate  = mymodel[i].engagement_rate
            annotations.rating  = mymodel[i].rating
            annotations.user_gender  = mymodel[i].user_gender
            annotations.min_user_exp_level  = mymodel[i].min_user_exp_level
            annotations.partner_id = mymodel[i].partner_id
            annotations.wht_wont_hav_to = mymodel[i].wht_wont_hav_to
            annotations.wht_thy_hav_to_do = mymodel[i].wht_thy_hav_to_do
            
            mapView.addAnnotation(annotations)
            
        }
    }
    
    

    //MARK: retrieving data from api
    
    func retriveData2(){
        
   
        let localModel = LocalModel()
        
        localModel.announcementImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLp88Fq4O7S3Kke19q6XuYBMa9aS-unqEcxYlSNVRsO5Z2i7qH"
        localModel.title = "Fashion Announcement"
        localModel.companyName = "Initech"
        localModel.location = "Alberta, Canada"
        localModel.productImage = ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLp88Fq4O7S3Kke19q6XuYBMa9aS-unqEcxYlSNVRsO5Z2i7qH","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLp88Fq4O7S3Kke19q6XuYBMa9aS-unqEcxYlSNVRsO5Z2i7qH","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLp88Fq4O7S3Kke19q6XuYBMa9aS-unqEcxYlSNVRsO5Z2i7qH"]
        localModel.palceImages = ["",""]
        localModel.reviews = ["",""]
        localModel.date = "27-August-2019"
        localModel.description = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem"
        localModel.collaborattionTerms = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem"
        localModel.avalaibility = ""
        localModel.selectedNumOfFollowers = "700"
        localModel.lat = 24.8591
        localModel.long = 67.0666
        
        self.model.append(localModel)
        
        
        
    }
    
    func retriveData(completion: @escaping () -> Void){
        
        let parameters : [String:String] = [
            "collabrubType": "local"
            
        ]
        
        Alamofire.request("\(self.url.weburl)/all_collaboration.php", method: .get, parameters: parameters).responseJSON { (response) in
            
            SVProgressHUD.show(withStatus: "Connecting to server")
            
            if response.result.isSuccess {
                
                SVProgressHUD.dismiss()
                let dataJSON : JSON = JSON(response.result.value!)
                //print("dataJSON1\(dataJSON)")
                
                let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                //  print(dataJSON.count)
                self.model.removeAll()
                
                for item in 0..<dataJSON.count {
                    //print(dataJSON[item])
                    // let localModel = LocalModel()
                    SVProgressHUD.show(withStatus: "Loading")
                    let para : [String:Int] = [
                        "id" : dataJSON[item]["collaboration_id"].intValue
                    ]
                    Alamofire.request("\(self.url.weburl)/collabrubImages.php", method: .get, parameters: para).responseJSON { (response) in
                        
                        if response.result.isSuccess {
                            
                            let dataJSON1 : JSON = JSON(response.result.value!)
                            // let followers = dataJSON["data"]["counts"]["followed_by"].intValue
                            //                            print(dataJSON[item])
                            //                             print(dataJSON1)
                            
                            let localModel = LocalModel()
                            
                            
                            localModel.announcementImage = dataJSON1[0]["img_url"].stringValue
                            localModel.title = dataJSON[item]["collaboration_name"].stringValue
                            localModel.companyName = dataJSON[item]["company_name"].stringValue
                            localModel.location = dataJSON[item]["address"].stringValue
                            localModel.productImage = [dataJSON1[0]["img_url"].stringValue,dataJSON1[1]["img_url"].stringValue,dataJSON1[2]["img_url"].stringValue]
                            localModel.palceImages = ["",""]
                            localModel.reviews = ["",""]
                            localModel.date = dataJSON[item]["date"].stringValue
                            localModel.description = dataJSON[item]["descriptions"].stringValue
                            localModel.collaborattionTerms = dataJSON[item]["collaboration_terms"].stringValue
                            localModel.avalaibility = ""
                            localModel.selectedNumOfFollowers = dataJSON[item]["followers_limit"].stringValue
                            
                            localModel.collaboration_id = dataJSON[item]["collaboration_id"].stringValue
                            
                            localModel.expiry_date = dataJSON[item]["expiry_date"].stringValue
                            localModel.Accep_budget_check = dataJSON[item]["Accep_budget_check"].stringValue
                            localModel.budget_value = dataJSON[item]["budget_value"].stringValue
                            localModel.type = dataJSON[item]["type"].stringValue
                            localModel.discount_field = dataJSON[item]["discount_field"].stringValue
                            localModel.content_type = dataJSON[item]["content_type"].stringValue
                            localModel.required_city = dataJSON[item]["required_city"].stringValue
                            localModel.required_region = dataJSON[item]["required_region"].stringValue
                            localModel.engagement_rate = dataJSON[item]["engagement_rate"].stringValue
                            localModel.rating = dataJSON[item]["rating"].stringValue
                            localModel.user_gender = dataJSON[item]["user_gender"].stringValue
                            localModel.min_user_exp_level = dataJSON[item]["min_user_exp_level"].stringValue
                            localModel.lat = dataJSON[item]["lat"].doubleValue
                            localModel.long = dataJSON[item]["longg"].doubleValue
                            
                            localModel.wht_wont_hav_to = dataJSON[item]["wht_wont_hav_to"].stringValue
                            localModel.wht_thy_hav_to_do = dataJSON[item]["wht_thy_hav_to_do"].stringValue
                            localModel.partner_id = dataJSON[item]["partner_id"].stringValue
                            
                            self.model.append(localModel)
                            
                            //   SVProgressHUD.dismiss()
                            
                            completion()
                        }else {
                            print("error not get in first")
                            completion()
                        }
                        
                        //print("count \(self.model.count)")
                        SVProgressHUD.dismiss()
//                        self.collectionView.reloadData()
                    
                    
                    }
                }
//                self.status = true
                
                
                
                super.viewDidLoad()
                
                
            
            }else {
                print("error not get in second")
                
            }
            
        }
        
       
        
    }
    
    // action:#selector(Class.MethodName) for swift 3
    
    @objc func action(){
        performSegue(withIdentifier: "sideMenu", sender: self)
    }
    
    
    @IBAction func collabrubBtnClicked(_ sender: UIButton) {
        
      
        
//        let stroy = UIStoryboard(name: "Main", bundle: nil)
//        let vc = stroy.instantiateViewController(withIdentifier: "pakage")
//
//        self.addChild(vc)
//        self.view.addSubview(vc.view)
//        vc.didMove(toParent: self)
        
        
    }
    
    //MARK: navigatio image setup
    
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    

}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //performSegue(withIdentifier: "mapDetail", sender: self)
        //print(view.annotation?.title)
        
        myView.isHidden = false
        let anno = view.annotation as! customAnnoation
        imgCollabrub.sd_setImage(with: URL(string:(anno.announcementImage)))
        collabrubTitle.text = anno.title
        collabrubDescrip.text = anno.description1
        numOfFollowers.text = anno.selectedNumOfFollowers
        modelAnnoation = anno
        btnCollabrub.addTarget(self, action: #selector(MapViewController.perFormEvent), for: .touchUpInside)
        
        
    }
    
    @objc func perFormEvent(){
        performSegue(withIdentifier: "mapDetail", sender: self)
        //print(modelAnnoation.selectedNumOfFollowers)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapDetail" {
            let destinationVC = segue.destination as! LocalDetailsViewController
            destinationVC.modelCustom = modelAnnoation
        }
    }
    
}
